# Module Specifics

Core Version Constraints:
* `>= 0.13.5`

Provider Requirements:
* **aws:** (any version)

## Input Variables
* `attributes` (required): Additional attributes (e.g. `1`)
* `audit_access_logs_create` (default `true`): True if a S3 access audit logging bucket should be created
* `audit_s3_access_bucket_name` (default `"audit-s3-logs"`): Bucket name used for S3 access audit logging
* `delimiter` (default `"-"`): Delimiter to be used between `name`, `namespace`, `stage`, etc.
* `environment` (required): Environment or product (e.g. `playground`, `shared`, `organisation`)
* `iam_create_readonly_role` (default `true`): Create readonly role or not
* `iam_create_terraform_role` (default `true`): Create Terraform role or not
* `iam_terraform_role_name` (default `"terraform"`): Terraform role name (used in automation tools)
* `kms_create_secrets` (required): Create a KMS key for Terraform (used for sensitive data in resources)
* `kms_key_id` (required): AWS KMS master key ID used for SSE-KMS encryption. The default AWS/S3 AWS KMS master key is used if this element is absent
* `kms_terraform_principles` (required): List of IAM principles that are authorised to encrypt/decrypt secrets
* `namespace` (required): Namespace - typically the company name (e.g. `MyCorp`)
* `security_account_id` (required): ID of the security account where the IAM users/roles are located
* `stage` (required): Stage (e.g. `dev`, `test`, `prod`)
* `tags` (required): A map of tags to add to all resources

## Output Values
* `iam_readonly_role`: IAM readonly role
* `iam_terraform_role`: IAM Terraform group ID
* `kms_teraform_key_id`: Terraform secrets KMS key ID
* `s3_auditaccess`: S3 audit access log bucket name
* `s3_auditaccess_bucket_arn`: Bucket ARN
* `s3_auditaccess_bucket_domain_name`: FQDN of bucket
* `s3_auditaccess_bucket_id`: Bucket Name (aka ID)

## Managed Resources
* `aws_iam_role.readonly` from `aws`
* `aws_iam_role.terraform` from `aws`
* `aws_iam_role_policy_attachment.readonly_policy` from `aws`
* `aws_iam_role_policy_attachment.teraform_policy` from `aws`
* `aws_kms_key.terraform_secrets` from `aws`
* `aws_s3_bucket.audit_access_logs` from `aws`
* `aws_s3_bucket_public_access_block.audit_s3_access` from `aws`

## Data Resources
* `data.aws_caller_identity.current_user` from `aws`
* `data.aws_iam_policy_document.assume_role` from `aws`
* `data.aws_iam_policy_document.kms_terraform_policy` from `aws`
* `data.aws_iam_policy_document.readonly_assume_role` from `aws`

## Child Modules
* `audit_access_s3_label` from `git::https://github.com/cloudposse/terraform-null-label.git?ref=master`

## Problems

## Error: Unsuitable value type

(at `versions.tf` line 5)

Unsuitable value: string required

