resource "aws_iam_role" "role_b_uploader" {
  name = "uploadonly_s3_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect    = "Allow",
      Principal = {
        Service = "ec2.amazonaws.com"
      },
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_policy" "uploadonly_policy" {
  name        = "uploadonly_s3_policy"
  description = "Allows write-only access to S3"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "s3:PutObject",
          "s3:CreateBucket"
        ],
        Effect   = "Allow",
        Resource = ["arn:aws:s3:::${var.log_s3_bucket_name}", "arn:aws:s3:::${var.log_s3_bucket_name}/*"]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "uploadonly_attach" {
  role       = aws_iam_role.role_b_uploader.name
  policy_arn = aws_iam_policy.uploadonly_policy.arn
}