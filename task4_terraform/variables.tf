variable "region" {
  default = "ap-south-1"
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
  default     = "vpc-01b35def73b166fdc"
}

variable "subnet_id" {
  description = "Public Subnet ID"
  type        = string
}

variable "dockerhub_username" {
  type        = string
  description = "Docker Hub username"
}

variable "dockerhub_token" {
  type        = string
  description = "Docker Hub access token"
  sensitive   = true
}

variable "image" {
  default     = "zayn63/zstrapi:latest"
  description = "Docker image to deploy"
}

variable "instance_type" {
  default = "t3.micro"
}

variable "allowed_cidr" {
  default     = "0.0.0.0/0"
  description = "Allowed CIDR for SSH and Strapi"
}
