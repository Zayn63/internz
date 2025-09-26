provider "aws" {
  region = var.aws_region
}

# Security Group (new unique name)
resource "aws_security_group" "strapi_sg" {
  name        = "strapi-sg-new"
  description = "Allow Strapi inbound traffic"
  vpc_id      = "vpc-01b35def73b166fdc"

  ingress {
    description = "Allow HTTP"
    from_port   = 1337
    to_port     = 1337
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "strapi-sg-new"
  }
}

# EC2 Instance
resource "aws_instance" "strapi" {
  ami           = "ami-0522ab6e1ddcc7055" # Amazon Linux 2 AMI (ap-south-1)
  instance_type = var.instance_type
  key_name      = var.ec2_key_pair_name
  security_groups = [aws_security_group.strapi_sg.name]

  user_data = templatefile("${path.module}/user_data.sh", {
    image_tag = var.image_tag
  })

  tags = {
    Name = "strapi-ec2"
  }
}
