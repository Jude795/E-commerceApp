#!/bin/bash

echo "Stopping existing container..."

docker stop devops-app 2>/dev/null
docker rm devops-app 2>/dev/null

echo "Starting new container..."

docker run -d \
  --name devops-app \
  -p 80:80 \
  devops-build:v1

echo "Application deployed successfully."
