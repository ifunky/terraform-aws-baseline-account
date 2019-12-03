<!-- Auto generated file -->

# AWS Common Account Baseline
 [![Build Status](https://circleci.com/gh/ifunky/terraform-aws-baseline-account.svg?style=svg)](https://circleci.com/gh/ifunky/terraform-aws-baseline-account) [![Latest Version](https://img.shields.io/github/release/ifunky/terraform-aws-baseline-account.svg)](https://github.com/ifunky/terraform-aws-baseline-account/releases)

Create baseline common AWS account settings that are applied to every account in the organisation.   This tyically includes config like IAM roles, S3 buckets and general settings.

## Features

### Account Cost Saving -> EC2 Scheduling

- Lambda function for scheduling start/stop of EC2 and RDS instances

### Identity and Access Management

- Creates a ReadOnly role
- Creates a Terraform role which is designed to be used by an automation pipeline

### S3 Buckets
- Creates an audit bucket for S3 access logs

### KMS Key For Sensitive Data
- A KMS key is created specifcally to enable Terraform to decrypt any sensitive data required for resources which require passwords

## EC2 Instance Scheduling
Each account comes with the ablilty to tag EC2 instances in order to save costs by automatically stopping and starting at predefined schedules each day.
By default EC2 instances will be stopped at 18:00 with no start time.  If you need a server running you can use the AWS Console to start instances again when you need them.

For more information see here: https://github.com/neillturner/terraform-aws-lambda-scheduler/



## Usage
```hcl
module "account" {
source = "git::https://github.com/ifunky/terraform-aws-baseline-account.git?ref=master"

  company             = "iFunky"
  environment         = "playground"
  stage               = "dev"
  security_account_id = var.security_account_id

  tags = {
    Terraform = "true"
  }
}
```


## Makefile Targets
The following targets are available: 

```
createdocs/help                Create documentation help
polydev/createdocs             Run PolyDev createdocs directly from your shell
polydev/help                   Help on using PolyDev locally
polydev/init                   Initialise the project
polydev/validate               Validate the code
polydev                        Run PolyDev interactive shell to start developing with all the tools or run AWS CLI commands :-)
```
# Module Specifics

Core Version Constraints:
* `~> 0.12.2`

Provider Requirements:
* **aws:** `~> 2.16`

## Input Variables
* `attributes` (required): Additional attributes (e.g. `1`)
* `audit_access_logs_create` (default `true`): True if a S3 access audit logging bucket should be created
* `audit_s3_access_bucket_name` (default `"audit-s3-logs"`): Bucket name used for S3 access audit logging
* `delimiter` (default `"-"`): Delimiter to be used between `name`, `namespace`, `stage`, etc.
* `environment` (required): Environment or product (e.g. `playground`, `shared`, `organisation`)
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

