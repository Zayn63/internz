resource "aws_cloudwatch_log_group" "ecs_strapi" {
  name              = "/ecs/strapi"
  retention_in_days = 30
  tags = { Name = "z-strapi-log-group" }
}
