output "alb_dns_name" {
  description = "Public ALB DNS name for accessing Strapi (HTTP)"
  value       = aws_lb.alb.dns_name
}

output "ecr_repository_url" {
  description = "ECR repository URL (use to push / verify image)"
  value       = aws_ecr_repository.repo.repository_url
}
