locals {
  container_definitions = jsonencode([{
    name      = "z-strapi"
    image     = var.image_uri
    essential = true
    portMappings = [{ containerPort = 1337, hostPort = 1337, protocol = "tcp" }]
    environment = [
      { name = "DATABASE_CLIENT", value = "postgres" },
      { name = "DATABASE_HOST", value = aws_db_instance.strapi.address },
      { name = "DATABASE_PORT", value = "5432" },
      { name = "DATABASE_NAME", value = "strapidb" },
      { name = "DATABASE_USERNAME", value = "strapi" },
      { name = "NODE_ENV", value = "production" }
    ]
    secrets = [{ name = "DATABASE_PASSWORD", valueFrom = "${aws_secretsmanager_secret.strapi_db.arn}:password::" }]
    logConfiguration = {
      logDriver = "awslogs"
      options = {
        "awslogs-group"         = aws_cloudwatch_log_group.ecs_strapi.name
        "awslogs-region"        = "ap-south-1"
        "awslogs-stream-prefix" = "ecs/strapi"
      }
    }
  }])
}

resource "aws_ecs_task_definition" "strapi" {
  family                   = var.task_family
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "512"
  memory                   = "1024"
  execution_role_arn       = var.execution_role_arn
  task_role_arn            = var.task_role_arn
  container_definitions    = local.container_definitions
}
