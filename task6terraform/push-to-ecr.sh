#!/usr/bin/env bash
set -euo pipefail

AWS_REGION="${AWS_REGION:-ap-south-1}"
IMAGE_TAG="${1:-latest}"
PREFIX="${2:-z}" # matches terraform default prefix

REPO_NAME="${PREFIX}-strapi"
ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text --region "${AWS_REGION}")
ECR_URL="${ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${REPO_NAME}"

echo "Building Docker image..."
docker build -t ${REPO_NAME}:${IMAGE_TAG} .

echo "Logging in to ECR..."
aws ecr get-login-password --region "${AWS_REGION}" | docker login --username AWS --password-stdin "${ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com"

echo "Tagging image..."
docker tag ${REPO_NAME}:${IMAGE_TAG} ${ECR_URL}:${IMAGE_TAG}

echo "Pushing to ECR: ${ECR_URL}:${IMAGE_TAG}"
docker push ${ECR_URL}:${IMAGE_TAG}

echo "Pushed. Image is: ${ECR_URL}:${IMAGE_TAG}"
