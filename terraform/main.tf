provider "aws" {
  region = var.aws_region
}

resource "aws_security_group" "allow_http_and_ssh" {
  name        = "allow_http_and_ssh"
  description = "Allow HTTP traffic and SSH traffic on port 80 and 22"

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
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "app_server" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  security_groups        = [aws_security_group.allow_http_and_ssh.name]
  iam_instance_profile = aws_iam_instance_profile.ec2_instance_profile_b.name

  associate_public_ip_address = true

  user_data = templatefile("${path.module}./scripts/user_data.sh.tftpl", {
    log_s3_bucket_name=var.log_s3_bucket_name
    REPO_URL = var.github_repo_url
    shutdown_after_minutes = var.shutdown_after_minutes
  })

  tags = {
    Name  = "AppServer-${var.stage}"
    Stage = var.stage
  }
}
