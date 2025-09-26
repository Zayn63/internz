resource "aws_ecr_repository" "zayn_strapi" {
  name                 = "zayn-strapi"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}


output "ecr_repository_name" {
value = aws_ecr_repository.zayn_strapi.name
}


output "ecr_repository_url" {
value = aws_ecr_repository.zayn_strapi.repository_url
}
