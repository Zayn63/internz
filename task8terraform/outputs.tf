output "alb_dns" {
  value = "z-strapi-alb-2051228102.ap-south-1.elb.amazonaws.com"
}

output "rds_endpoint" {
  value = aws_db_instance.strapi.address
}
