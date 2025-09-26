resource "aws_ecs_cluster" "zayn_cluster" {
name = "${var.prefix}-ecs-cluster"
}


output "ecs_cluster_name" {
value = aws_ecs_cluster.zayn_cluster.name
}