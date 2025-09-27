output "cluster_name" {
value = aws_ecs_cluster.zayn_cluster.name
}


output "service_name" {
value = aws_ecs_service.zayn_service.name
}


output "alb_dns" {
value = aws_lb.zayn_alb.dns_name
}