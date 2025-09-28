variable "aws_region" {
  description = "AWS region to use"
  type        = string
  default     = "ap-south-1"
}

variable "prefix" {
  description = "Resource name prefix"
  type        = string
  default     = "z"
}

variable "image_tag" {
  description = "Image tag to deploy (will be pushed to ECR by script). Example: latest or commit SHA"
  type        = string
  default     = "latest"
}

variable "container_port" {
  description = "Port Strapi listens on"
  type        = number
  default     = 1337
}

variable "desired_count" {
  description = "ECS service desired count"
  type        = number
  default     = 1
}
