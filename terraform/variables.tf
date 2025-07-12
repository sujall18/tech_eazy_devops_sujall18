variable "aws_region" {
  description = "The AWS region where resources will be deployed (e.g., us-east-1)"
  type        = string
}

variable "instance_type" {
  default = "t2.micro"
  type        = string
}

variable "ami_id" {
  description = "The AMI ID used to launch the EC2 instance"
  type        = string
}

variable "github_repo_url" {
  description = "The URL of the GitHub repository to be cloned on the EC2 instance"
  type        = string
}

variable "stage" {
  description = "Stage identifier to differentiate environments (e.g., dev, test, prod)"
  type        = string
}
variable "log_s3_bucket_name" {
  description = "Name of the S3 bucket to store logs"
  type        = string
}
variable"shutdown_after_minutes"{
  description = "Number of minutes after which EC2 instance should Auto-shutdown"
  type = number
}