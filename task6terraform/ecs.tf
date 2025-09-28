resource "aws_cloudwatch_log_group" "strapi" {
  name              = "/ecs/${local.name_prefix}-strapi"
  retention_in_days = 14
}

resource "aws_ecs_cluster" "cluster" {
  name = local.cluster_name
}

locals {
  image_fullname = "${aws_ecr_repository.repo.repository_url}:${var.image_tag}"
  container_definitions = jsonencode([
    {
      name  = "strapi"
      image = local.image_fullname
      portMappings = [
        {
          containerPort = var.container_port
          protocol      = "tcp"
        }
      ]
      essential = true
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = aws_cloudwatch_log_group.strapi.name
          awslogs-region        = var.aws_region
          awslogs-stream-prefix = "strapi"
        }
      }
    }
  ])
}

resource "aws_ecs_task_definition" "strapi" {
  family                   = "${local.name_prefix}-strapi-task"
  cpu                      = "512"
  memory                   = "1024"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  execution_role_arn       = var.ecs_task_execution_role_arn
  container_definitions    = local.container_definitions
}


resource "aws_security_group" "ecs_sg" {
  name   = "${local.name_prefix}-ecs-sg"
  vpc_id = data.aws_vpc.default.id
}

resource "aws_ecs_service" "strapi" {
  name            = "${local.name_prefix}-strapi-service"
  cluster         = aws_ecs_cluster.cluster.id
  task_definition = aws_ecs_task_definition.strapi.arn
  desired_count   = var.desired_count
  launch_type     = "FARGATE"

  network_configuration {
    subnets         = data.aws_subnets.default_vpc_subnets.ids
    security_groups = [aws_security_group.ecs_sg.id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.strapi_tg.arn
    container_name   = "strapi"
    container_port   = var.container_port
  }

  depends_on = [aws_lb_listener.front_end]
}
