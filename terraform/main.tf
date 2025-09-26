provider "aws" {
region = var.aws_region
}


resource "aws_security_group" "strapi_sg" {
name = "strapi_sg"
description = "Allow SSH, Strapi and Postgres"


ingress {
from_port = 22
to_port = 22
protocol = "tcp"
cidr_blocks = ["0.0.0.0/0"]
}


ingress {
from_port = 1337
to_port = 1337
protocol = "tcp"
cidr_blocks = ["0.0.0.0/0"]
}


ingress {
from_port = 5432
to_port = 5432
protocol = "tcp"
cidr_blocks = ["0.0.0.0/0"]
}


egress {
from_port = 0
to_port = 0
protocol = "-1"
cidr_blocks = ["0.0.0.0/0"]
}
}


data "aws_ami" "amazon_linux2" {
most_recent = true
owners = ["amazon"]
filter {
name = "name"
values = ["amzn2-ami-hvm-*-x86_64-gp2"]
}
}


resource "aws_instance" "strapi" {
ami = data.aws_ami.amazon_linux2.id
instance_type = var.instance_type
key_name = var.ec2_key_pair_name
vpc_security_group_ids = [aws_security_group.strapi_sg.id]


user_data = templatefile("${path.module}/user_data.tpl", {
image_tag = var.image_tag
})


tags = {
Name = "strapi-ec2"
}
}
}