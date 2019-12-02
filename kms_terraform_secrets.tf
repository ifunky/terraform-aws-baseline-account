# This key is used by Terraform to encrypt/decrypt sensitive data/passwords used in resources

data "aws_caller_identity" "current_user" {}

data "aws_iam_policy_document" "kms_terraform_policy" {
  statement {
    effect = "Allow"
    actions = ["kms:*"]

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current_user.account_id}:root"]
    }
    resources = ["*"]    
  }

  statement {
    effect = "Allow"
    actions = ["kms:*"]

    principals {
      type        = "AWS"
      identifiers = var.kms_terraform_principles
    }
    resources = ["*"]    
  }  
}

resource "aws_kms_key" "terraform_secrets" {
    description = "Key used by Terraform for sensitive data used in resources"
    is_enabled  = true

    policy = data.aws_iam_policy_document.kms_terraform_policy.json
}