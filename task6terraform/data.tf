# Default VPC
data "aws_vpc" "default" {
  default = true
}

# All subnets in default VPC
data "aws_subnets" "default_vpc_subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

locals {
  # ALB needs at least two subnets; slice will pick first two
  alb_subnet_ids = slice(data.aws_subnets.default_vpc_subnets.ids, 0, 2)
}
