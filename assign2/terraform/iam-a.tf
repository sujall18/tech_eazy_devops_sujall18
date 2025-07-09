resource "aws_iam_role" "role_a_readonly" {
  name = "readonly_s3_role"

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

resource "aws_iam_policy" "readonly_policy" {
  name        = "readonly_s3_policy"
  description = "Allows read-only access to S3"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "s3:GetObject",
          "s3:ListBucket"
        ],
        Effect   = "Allow",
        Resource = ["arn:aws:s3:::${var.log_s3_bucket_name}", "arn:aws:s3:::${var.log_s3_bucket_name}/*"]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "readonly_attach" {
  role       = aws_iam_role.role_a_readonly.name
  policy_arn = aws_iam_policy.readonly_policy.arn
}