resource "aws_iam_instance_profile" "ec2_instance_profile_b" {
  name = "ec2-instance-profile_b-${var.stage}"
  role = aws_iam_role.role_b_uploader.name
}

resource "aws_iam_instance_profile" "ec2_instance_profile_a" {
  name = "ec2-instance-profile_a-${var.stage}"
  role = aws_iam_role.role_a_readonly.name
}