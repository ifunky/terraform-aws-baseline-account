module "audit_access_s3_label" {
  source     = "git::https://github.com/cloudposse/terraform-null-label.git?ref=0.22.0"
  enabled    = var.audit_access_logs_create
  namespace  = var.namespace
  environment= var.environment
  stage      = var.stage
  name       = var.audit_s3_access_bucket_name
  delimiter  = var.delimiter
  attributes = var.attributes
  tags       = var.tags
}

resource "aws_s3_bucket" "audit_access_logs" {
  count         = var.audit_access_logs_create ? 1 : 0
  bucket        = module.audit_access_s3_label.id
  force_destroy = false

  tags = merge(tomap({ "Name" = var.audit_s3_access_bucket_name}), var.tags)
}

resource "aws_s3_bucket_server_side_encryption_configuration" "audit_access_logs" {
  count         = var.audit_access_logs_create ? 1 : 0  
  bucket        = aws_s3_bucket.audit_access_logs[count.index].id

  rule {
    apply_server_side_encryption_by_default {
        kms_master_key_id = var.kms_key_id
        sse_algorithm     = var.kms_key_id == "" ? "AES256" : "aws:kms"
    }
  }
}

resource "aws_s3_bucket_ownership_controls" "audit_access_logs" {
  count         = var.audit_access_logs_create ? 1 : 0  
  bucket        = aws_s3_bucket.audit_access_logs[count.index].id
  rule {
    object_ownership = "ObjectWriter"
  }
}


resource "aws_s3_bucket_public_access_block" "audit_s3_access" {
  count               = var.audit_access_logs_create ? 1 : 0
  bucket              = aws_s3_bucket.audit_access_logs[count.index].id

  block_public_acls   = true
  block_public_policy = true

  ignore_public_acls  = true
}