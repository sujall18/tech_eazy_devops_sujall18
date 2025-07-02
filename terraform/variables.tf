#variable "aws_access_key" {
#  description = "Your AWS Access Key"
#  type        = string
#}

#variable "aws_secret_key" {
#  description = "Your AWS Secret Key"
#  type        = string
#}

variable "aws_region" {
  description = "AWS region for deployment"
  type        = string
  default     = "ap-south-1"
}

variable "key_name" {
  description = "Name of your EC2 key pair"
  type        = string
  default     = "example"  # Replace with your actual key pair name
}

variable "stage" {
  description = "Environment stage: dev or prod"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
  default     = "ami-0f918f7e67a3323f0"  # Ubuntu 22.04 (free tier) in ap-south-1
}

variable "readonly_role_name" {
  description = "Name for S3 read-only IAM role"
  type        = string
  default     = "s3-readonly-role"
}

variable "upload_role_name" {
  description = "Name for S3 upload-only IAM role"
  type        = string
  default     = "s3-upload-role"
}

variable "bucket_name" {
  description = "S3 bucket name for logs"
  type        = string

  validation {
    condition     = length(var.bucket_name) > 0
    error_message = "The bucket_name variable must be provided and cannot be empty."
  }
}
