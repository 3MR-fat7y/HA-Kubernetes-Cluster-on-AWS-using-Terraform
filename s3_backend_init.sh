#!/bin/bash

# =========================
# Terraform Backend Config
# =========================

BUCKET_NAME="my-terraform-states-omar"
REGION="us-east-1"
DYNAMODB_TABLE="terraform-locks"

echo "======================================"
echo "Creating S3 bucket for Terraform state"
echo "======================================"

aws s3api create-bucket \
  --bucket $BUCKET_NAME \
  --region $REGION

echo "======================================"
echo "Enabling Versioning on S3 bucket"
echo "======================================"

aws s3api put-bucket-versioning \
  --bucket $BUCKET_NAME \
  --versioning-configuration Status=Enabled

echo "======================================"
echo "Creating DynamoDB table for locking"
echo "======================================"

aws dynamodb create-table \
  --table-name $DYNAMODB_TABLE \
  --attribute-definitions AttributeName=LockID,AttributeType=S \
  --key-schema AttributeName=LockID,KeyType=HASH \
  --billing-mode PAY_PER_REQUEST

echo "======================================"
echo "✅ Terraform Backend Created Successfully!"
echo "Bucket: $BUCKET_NAME"
echo "DynamoDB Table: $DYNAMODB_TABLE"
echo "Region: $REGION"
echo "======================================"
