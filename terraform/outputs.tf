output "ec2_public_ip" {
  value = aws_instance.devops_instance.public_ip
  description = "Public IP of the deployed EC2 instance"
}