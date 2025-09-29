resource "random_password" "db_password" {
  length            = 20
  special           = true
  override_char_set = "!@#0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
}

resource "aws_db_subnet_group" "strapi" {
  name       = "z-strapi-db-subnet-group"
  subnet_ids = var.subnet_ids
  tags       = { Name = "z-strapi-db-subnet-group" }
}

resource "aws_security_group" "rds_sg" {
  name        = "z-strapi-rds-sg"
  description = "Allow Postgres from ECS SG"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [var.ecs_sg]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "z-strapi-rds-sg" }
}

resource "aws_db_instance" "strapi" {
  identifier             = "z-strapi-db"
  allocated_storage      = 20
  engine                 = "postgres"
  engine_version         = "15.4"
  instance_class         = "db.t3.micro"
  username               = "strapi"
  password               = random_password.db_password.result
  db_name                = "strapidb"
  db_subnet_group_name   = aws_db_subnet_group.strapi.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  skip_final_snapshot    = true
  publicly_accessible    = false
  storage_encrypted      = true
  multi_az               = false
  apply_immediately      = false
  tags = { Name = "z-strapi-db" }
}
