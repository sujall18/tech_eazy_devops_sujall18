resource "aws_s3_bucket" "log_s3_bucket" {
  bucket = var.log_s3_bucket_name
  force_destroy = true

  tags = {
    Name = "LogBucket"
  }
}

resource "aws_s3_bucket_public_access_block" "log_bucket" {
 bucket = aws_s3_bucket.log_s3_bucket.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_lifecycle_configuration" "log_lifecycle" {
  bucket = aws_s3_bucket.log_s3_bucket.id

  rule {
    id     = "delete_logs_after_7_days"
    status = "Enabled"

    expiration {
      days = 7
    }

    filter {}
  }
}