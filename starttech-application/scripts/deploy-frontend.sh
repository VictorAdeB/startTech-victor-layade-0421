#!/bin/bash
set -e

FRONTEND_BUCKET=$1
DISTRIBUTION_ID=$2

if [ -z "$FRONTEND_BUCKET" ] || [ -z "$DISTRIBUTION_ID" ]; then
  echo "Usage: deploy-frontend.sh <bucket-name> <cloudfront-id>"
  exit 1
fi

echo "Building frontend..."
npm install
npm run build

echo "Deploying to S3..."
aws s3 sync build/ s3://$FRONTEND_BUCKET --delete

echo "Invalidating CloudFront cache..."
aws cloudfront create-invalidation \
  --distribution-id $DISTRIBUTION_ID \
  --paths "/*"

echo "Frontend deployment complete"
