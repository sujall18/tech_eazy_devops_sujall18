data "aws_iam_policy_document" "assume_ec2" {
  statement {
    effect = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

######################################
# Role A – S3 Read-Only IAM Role
######################################

resource "aws_iam_role" "s3_readonly_role" {
  name               = "${var.readonly_role_name}-s3-readonly"
  assume_role_policy = data.aws_iam_policy_document.assume_ec2.json
}

resource "aws_iam_role_policy_attachment" "readonly_attach" {
  role       = aws_iam_role.s3_readonly_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
}

######################################
# Role B – S3 Upload-Only IAM Role
######################################

data "aws_iam_policy_document" "s3_upload_only_policy" {
  statement {
    effect = "Allow"
    actions = [
      "s3:CreateBucket",
      "s3:PutObject",
      "s3:PutObjectAcl",
      "s3:PutBucketLifecycleConfiguration"
    ]
    resources = ["*"]
  }

  statement {
    effect = "Deny"
    actions = [
      "s3:GetObject",
      "s3:ListBucket",
      "s3:GetBucketLocation"
    ]
    resources = ["*"]
  }
}

resource "aws_iam_role" "s3_upload_only_role" {
  name               = "${var.upload_role_name}-s3-upload-only"
  assume_role_policy = data.aws_iam_policy_document.assume_ec2.json

  inline_policy {
    name   = "upload-only"
    policy = data.aws_iam_policy_document.s3_upload_only_policy.json
  }
}

resource "aws_iam_instance_profile" "s3_upload_only_profile" {
  name = "${var.upload_role_name}-upload-instance-profile"
  role = aws_iam_role.s3_upload_only_role.name
}
