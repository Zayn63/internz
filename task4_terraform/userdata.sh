#!/bin/bash
set -e

# Update system and install Docker
yum update -y
amazon-linux-extras install docker -y
yum install -y docker
systemctl start docker
systemctl enable docker
usermod -aG docker ec2-user
sleep 5

# Docker Hub login
echo "${DOCKER_PASS}" | docker login -u "${DOCKER_USER}" --password-stdin

# Pull Strapi image
docker pull "${IMAGE}"

# Remove old container if exists
docker rm -f zname-strapi || true

# Run Strapi container
docker run -d --name zname-strapi \
  -p 1337:1337 \
  -e NODE_ENV=production \
  --restart unless-stopped "${IMAGE}"
