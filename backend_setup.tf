# 1. S3 Bucket to store Terraform state files
resource "aws_s3_bucket" "terraform_state" {
  bucket = "fluxio-terraform-state-toure-2026"

  # Safety measure: Prevents accidental deletion of the state bucket
  lifecycle {
    prevent_destroy = true
  }
}

# 2. Enable versioning for state recovery and rollback
resource "aws_s3_bucket_versioning" "enabled" {
  bucket = aws_s3_bucket.terraform_state.id
  versioning_configuration {
    status = "Enabled"
  }
}

# 3. DynamoDB table for state locking to prevent concurrent executions
resource "aws_dynamodb_table" "terraform_locks" {
  name         = "fluxio-terraform-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}
