#!/bin/bash
set -e

echo "Rolling back ASG to previous stable version..."

aws autoscaling cancel-instance-refresh \
  --auto-scaling-group-name starttech-api-asg

echo "Rollback initiated"
