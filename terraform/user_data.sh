#!/bin/bash
set -x


yum update -y
amazon-linux-extras install docker -y || yum install -y docker
service docker start
usermod -a -G docker ec2-user
sleep 5


# Run Postgres container
docker run -d \
--name postgres-container \
-e POSTGRES_USER=strapi \
-e POSTGRES_PASSWORD=strapi \
-e POSTGRES_DB=strapi \
-p 5432:5432 \
postgres:14


# Wait for Postgres
sleep 20


# Run Strapi container with DB env vars
docker run -d \
--name strapi-container \
-p 1337:1337 \
-e DATABASE_CLIENT=postgres \
-e DATABASE_NAME=strapi \
-e DATABASE_HOST=localhost \
-e DATABASE_PORT=5432 \
-e DATABASE_USERNAME=strapi \
-e DATABASE_PASSWORD=strapi \
zayn63/zstrapi:${image_tag}