resource "aws_s3_bucket" "log_bucket" {
  bucket = var.bucket_name

  force_destroy = true

  tags = {
    Name  = "DevOps Log Bucket"
    Stage = var.stage
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "log_bucket_lifecycle" {
  bucket = aws_s3_bucket.log_bucket.id

    # Lifecycle rule to delete logs after 7 days

    rule {
        id      = "delete-old-logs"
        status = "Enabled"
        filter {
                prefix = "logs/"  # Uncomment if you want to filter by prefix      
        }
        expiration {
            days = 7  # Deletes logs after 7 days
        }
    }
}

# Block public access
resource "aws_s3_bucket_public_access_block" "log_bucket_block" {
  bucket = aws_s3_bucket.log_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true


    
}
