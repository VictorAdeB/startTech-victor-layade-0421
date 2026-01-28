#!/bin/bash
set -e

ALB_URL=$1

if [ -z "$ALB_URL" ]; then
  echo "Usage: health-check.sh <alb-dns-name>"
  exit 1
fi

echo "Checking health endpoint..."
STATUS=$(curl -s -o /dev/null -w "%{http_code}" http://$ALB_URL/health)

if [ "$STATUS" != "200" ]; then
  echo "Health check FAILED"
  exit 1
fi

echo "Health check PASSED"
