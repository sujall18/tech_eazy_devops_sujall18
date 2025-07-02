output "ec2_public_ip" {
  value = aws_instance.devops_instance.public_ip
  description = "Public IP of the deployed EC2 instance"
}

output "readonly_role_arn" {
  value       = aws_iam_role.s3_readonly_role.arn
  description = "IAM role ARN for read-only S3 access"
}

output "upload_only_role_arn" {
  value       = aws_iam_role.s3_upload_only_role.arn
  description = "IAM role ARN for upload-only S3 access"
}

output "s3_bucket_name" {
  value       = aws_s3_bucket.log_bucket.bucket
  description = "S3 bucket used to store EC2 logs"
}
