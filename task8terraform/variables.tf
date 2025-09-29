variable "vpc_id" { type = string, default = "vpc-01b35def73b166fdc" }
variable "subnet_ids" {
  type = list(string)
  default = [
    "subnet-0393e7c5b435bd5b6",
    "subnet-03e1b3fe2ad999849",
    "subnet-05e9035d969355719"
  ]
}
variable "alb_sg" { type = string, default = "sg-0a25f15e102f529de" }
variable "ecs_sg" { type = string, default = "sg-0407d3bf3b206a0f5" }
variable "image_uri" { type = string, default = "zayn63/strapi:latest" }
variable "task_family" { type = string, default = "z-strapi-task" }
variable "execution_role_arn" { type = string, default = "arn:aws:iam::145065858967:role/zayn-ecs-task-exec-role" }
variable "task_role_arn" { type = string, default = "arn:aws:iam::145065858967:role/zayn-ecs-task-exec-role" }
