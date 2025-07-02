terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region     = var.aws_region
#  access_key = var.aws_access_key
#  secret_key = var.aws_secret_key
}

resource "aws_security_group" "allow_http" {
  name        = "allow_http_${var.stage}"
  description = "Allow HTTP traffic on port 80"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Replace with your IP address
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "devops_instance" {
  ami                    = var.ami_id  # Ubuntu 22.04 (free tier) in ap-south-1
  instance_type          = var.instance_type
#  key_name               = file("C:/Users/SUJAL/Downloads/example.pem")
  vpc_security_group_ids = [aws_security_group.allow_http.id]
  
  iam_instance_profile   = aws_iam_instance_profile.s3_upload_only_profile.name
  associate_public_ip_address = true

  user_data              = base64encode(templatefile("../scripts/user_data.sh", {
    S3_BUCKET_NAME = var.bucket_name
  }))

  tags = {
    Name = "DevOps-${var.stage}-Instance"
  }
}
