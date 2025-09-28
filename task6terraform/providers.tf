provider "aws" {
  region = var.aws_region
}

locals {
  name_prefix  = var.prefix
  cluster_name = "${local.name_prefix}-strapi-cluster"
  ecr_repo_name = "${local.name_prefix}-strapi"
  alb_name     = "${local.name_prefix}-strapi-alb"
}
