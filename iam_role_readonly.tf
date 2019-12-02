data "aws_iam_policy_document" "readonly_assume_role" {
  statement {
    effect = "Allow"

    actions = ["sts:AssumeRole"]

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${var.security_account_id}:root"]
    }
  }
}

resource "aws_iam_role" "readonly" {
  name                 = "readonly"
  description          = "Role that can be assumed with only limited readonly access to this accounts resources"
  path                 = "/"
  max_session_duration = "3600"
  assume_role_policy = data.aws_iam_policy_document.readonly_assume_role.json

  tags = merge(map( "Name", "terraform"), var.tags )
}

resource "aws_iam_role_policy_attachment" "readonly_policy" {
  role       = aws_iam_role.readonly.name
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}