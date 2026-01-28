#!/bin/bash
set -e

IMAGE_TAG=$1

if [ -z "$IMAGE_TAG" ]; then
  echo "Usage: deploy-backend.sh <docker-image-tag>"
  exit 1
fi

echo "Triggering ASG rolling update..."

aws autoscaling start-instance-refresh \
  --auto-scaling-group-name starttech-api-asg \
  --preferences MinHealthyPercentage=50 \
  --strategy Rolling

echo "Backend deployment triggered with image $IMAGE_TAG"
