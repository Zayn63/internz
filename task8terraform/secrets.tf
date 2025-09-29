resource "aws_secretsmanager_secret" "strapi_db" {
  name        = "z/strapi/db"
  description = "Strapi DB credentials"
}

resource "aws_secretsmanager_secret_version" "strapi_db_version" {
  secret_id     = aws_secretsmanager_secret.strapi_db.id
  secret_string = jsonencode({
    username = "strapi"
    password = random_password.db_password.result
    host     = aws_db_instance.strapi.address
    port     = 5432
    dbname   = "strapidb"
  })
}

data "aws_iam_role" "exec_role" { name = "zayn-ecs-task-exec-role" }

resource "aws_iam_policy" "allow_secrets" {
  name = "z-strapi-allow-secrets"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Action = ["secretsmanager:GetSecretValue","secretsmanager:DescribeSecret"],
      Resource = [aws_secretsmanager_secret.strapi_db.arn]
    }]
  })
}

resource "aws_iam_role_policy_attachment" "attach_exec_secrets" {
  role       = data.aws_iam_role.exec_role.name
  policy_arn = aws_iam_policy.allow_secrets.arn
}
