#!/bin/bash
echo "Please wait till Docker builds the image"
docker build -t devops-build:v1 .
echo "Image built successfully"
