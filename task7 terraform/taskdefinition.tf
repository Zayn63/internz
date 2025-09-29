data "aws_ecr_repository" "strapi" {
  name = aws_ecr_repository.strapi.name
}

locals {
  image_uri = "${data.aws_ecr_repository.strapi.repository_url}:${var.image_tag}"
}

resource "aws_ecs_task_definition" "strapi" {
  family                   = "${var.project_name}-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = tostring(var.cpu)
  memory                   = tostring(var.memory)
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  container_definitions = jsonencode([
    {
      name      = "strapi"
      image     = local.image_uri
      essential = true
      portMappings = [
        {
          containerPort = var.container_port
          protocol      = "tcp"
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = "/ecs/${var.project_name}"
          awslogs-region        = var.aws_region
          awslogs-stream-prefix = "ecs"
        }
      }
      environment = [
        { name = "NODE_ENV", value = "production" }
        # add other env vars (DB, STRAPI keys) via secrets or environment as needed
      ]
    }
  ])
}
