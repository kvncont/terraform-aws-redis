data "aws_iam_role" "app" {
  name = var.app_role_name
}

resource "aws_iam_role_policy" "add_on" {
  name = "CustomSecretManagerPolicy"
  role = data.aws_iam_role.app.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "AllowSecretsManagerRead"
        Effect = "Allow"
        Action = [
          "secretsmanager:GetSecretValue",
          "secretsmanager:DescribeSecret"
        ]
        Resource = local.redis_arn
      }
    ]
  })
}