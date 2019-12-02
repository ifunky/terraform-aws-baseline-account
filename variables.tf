variable "namespace" {
  description = "Namespace - typically the company name (e.g. `MyCorp`)"
  type        = string
  default     = ""
}

variable "environment" {
  description = "Environment or product (e.g. `playground`, `shared`, `organisation`)"
  type        = string
  default     = ""
}

variable "stage" {
  description = "Stage (e.g. `dev`, `test`, `prod`)"
  type        = string
  default     = ""
}

variable "delimiter" {
  type        = string
  default     = "-"
  description = "Delimiter to be used between `name`, `namespace`, `stage`, etc."
}

variable "attributes" {
  type        = list(string)
  default     = []
  description = "Additional attributes (e.g. `1`)"
}

variable "audit_access_logs_create" {
    type        = bool
    description = "True if a S3 access audit logging bucket should be created"
    default     = true
}

variable "audit_s3_access_bucket_name" {
  description = "Bucket name used for S3 access audit logging"
  default     = "audit-s3-logs"
}

variable "kms_key_id" {
  description = "AWS KMS master key ID used for SSE-KMS encryption. The default AWS/S3 AWS KMS master key is used if this element is absent"
  default     = ""
}

variable "kms_terraform_principles" {
  type        = list(string)
  description = "List of IAM principles that are authorised to encrypt/decrypt secrets"
  default     = []
}

variable "security_account_id" {
  description = "ID of the security account where the IAM users/roles are located"
}

variable "tags" {
  description = "A map of tags to add to all resources"
  default     = {}
}
