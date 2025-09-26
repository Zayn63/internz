
# Security group for ALB and service (if not provided externally)
resource "aws_security_group" "zayn_alb_sg" {
name = "${var.prefix}-alb-sg"
description = "ALB SG"
vpc_id = var.vpc_id


ingress {
from_port = 80
to_port = 80
protocol = "tcp"
cidr_blocks = ["0.0.0.0/0"]
}


egress {
from_port = 0
to_port = 0
protocol = "-1"
cidr_blocks = ["0.0.0.0/0"]
}
}


resource "aws_lb" "zayn_alb" {
name = "${var.prefix}-alb"
internal = false
load_balancer_type = "application"
subnets = var.subnet_ids
security_groups = [aws_security_group.zayn_alb_sg.id]
}


resource "aws_lb_target_group" "zayn_tg" {
name = "${var.prefix}-tg"
port = var.container_port
protocol = "HTTP"
vpc_id = var.vpc_id
target_type = "ip"
}


resource "aws_lb_listener" "front_end" {
load_balancer_arn = aws_lb.zayn_alb.arn
port = 80
protocol = "HTTP"


default_action {
type = "forward"
target_group_arn = aws_lb_target_group.zayn_tg.arn
}
}


resource "aws_ecs_service" "zayn_service" {
name = "${var.prefix}-strapi-service"
cluster = aws_ecs_cluster.zayn_cluster.id
task_definition = aws_ecs_task_definition.zayn_task.arn
desired_count = var.desired_count
launch_type = "FARGATE"


network_configuration {
subnets = var.subnet_ids
security_groups = var.security_group_ids
assign_public_ip = true
}


load_balancer {
target_group_arn = aws_lb_target_group.zayn_tg.arn
}