
data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    actions = ["sts:AssumeRole"]

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${var.security_account_id}:root"]
    }
  }
}

resource "aws_iam_role" "terraform" {
  count                = var.iam_create_terraform_role ? 1 : 0
  name                 = var.iam_terraform_role_name
  description          = "Role that can be assumed by the administration account for Terraform automation"
  path                 = "/service-accounts/"
  max_session_duration = "3600"
  assume_role_policy   = data.aws_iam_policy_document.assume_role.json

  tags = merge(map( "Name", "terraform"), var.tags )
}

resource "aws_iam_role_policy_attachment" "teraform_policy" {
  count      = var.iam_create_terraform_role ? 1 : 0
  role       = aws_iam_role.terraform[count.index].name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}