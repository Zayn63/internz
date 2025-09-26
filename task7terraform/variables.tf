variable "aws_region" {
type = string
default = "ap-south-1"
}


variable "prefix" {
type = string
default = "zayn"
}


variable "vpc_id" {
type = string
default = "" # set in terraform.tfvars if you want to use an existing VPC
}


variable "subnet_ids" {
type = list(string)
default = []
}


variable "security_group_ids" {
type = list(string)
default = []
}


variable "desired_count" {
type = number
default = 1
}


variable "container_port" {
type = number
default = 1337
}