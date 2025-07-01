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

#variable "key_name" {
#  description = "Name of your EC2 key pair"
#  type        = string
#}

variable "stage" {
  description = "Environment stage: dev or prod"
  type        = string
}
