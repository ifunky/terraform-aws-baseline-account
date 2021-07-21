output "iam_readonly_role" {
  value       = aws_iam_role.readonly 
  description = "IAM readonly role"
}

output "iam_terraform_role" {
  value       = join("", aws_iam_role.terraform.*) 
  description = "IAM Terraform role"
}

output "s3_auditaccess" {
  value       = aws_s3_bucket.audit_access_logs
  description = "S3 audit access log bucket name"
}

output "s3_auditaccess_bucket_domain_name" {
  value       = var.audit_access_logs_create ? join("", aws_s3_bucket.audit_access_logs.*.bucket_domain_name) : ""
  description = "FQDN of bucket"
}

output "s3_auditaccess_bucket_id" {
  value       = var.audit_access_logs_create ? join("", aws_s3_bucket.audit_access_logs.*.id) : ""
  description = "Bucket Name (aka ID)"
}

output "s3_auditaccess_bucket_arn" {
  value       = var.audit_access_logs_create ? join("", aws_s3_bucket.audit_access_logs.*.arn) : ""
  description = "Bucket ARN"
}

output "kms_teraform_key_id" {
  value       = var.kms_create_secrets ? join("", aws_kms_key.terraform_secrets.*.key_id) : ""    
  description = "Terraform secrets KMS key ID"
}