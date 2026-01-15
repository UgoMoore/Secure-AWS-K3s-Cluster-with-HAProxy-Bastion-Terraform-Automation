resource "aws_iam_policy" "s3_access" {
  name        = "EC2-S3-Access"
  description = "Allow EC2 to read/write S3 buckets"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:ListBucket"
        ],
        Resource = [
          "arn:aws:s3:::amazing-heights-terraform-state",
          "arn:aws:s3:::amazing-heights-terraform-state/*"
        ]
      }
    ]
  })
}
