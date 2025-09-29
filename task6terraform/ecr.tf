resource "aws_ecr_repository" "repo" {
  name = local.ecr_repo_name

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name = local.ecr_repo_name
  }
}
git 