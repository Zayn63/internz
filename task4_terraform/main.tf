provider "aws" {
  region = var.region
}

# Latest Amazon Linux 2 AMI
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

# Security group
resource "aws_security_group" "zname_strapi_sg" {
  name        = "zname-strapi-sg"
  description = "Allow SSH and Strapi"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.allowed_cidr]
  }

  ingress {
    from_port   = 1337
    to_port     = 1337
    protocol    = "tcp"
    cidr_blocks = [var.allowed_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "zname-strapi-sg"
  }
}

# EC2 instance
resource "aws_instance" "zname_strapi_ec2" {
  ami                         = data.aws_ami.amazon_linux.id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.zname_strapi_sg.id]

  user_data = templatefile("${path.module}/userdata.sh", {
    DOCKER_USER = var.dockerhub_username
    DOCKER_PASS = var.dockerhub_token
    IMAGE       = var.image
  })

  tags = {
    Name = "zname-strapi-ec2"
  }
}

output "strapi_public_ip" {
  value = aws_instance.zname_strapi_ec2.public_ip
}

output "strapi_url" {
  value = "http://${aws_instance.zname_strapi_ec2.public_ip}:1337"
}
