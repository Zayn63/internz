resource "aws_ecr_repository" "zayn_strapi" {
name = "${var.prefix}-strapi"
image_tag_mutability = "MUTABLE"
tags = {
Name = "${var.prefix}-strapi"
}
}


output "ecr_repository_name" {
value = aws_ecr_repository.zayn_strapi.name
}


output "ecr_repository_url" {
value = aws_ecr_repository.zayn_strapi.repository_url
}