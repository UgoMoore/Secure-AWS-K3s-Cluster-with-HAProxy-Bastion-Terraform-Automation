#########################
# IAM Role for EC2
#########################

resource "aws_iam_role" "ec2_role" {
  name = "k3s_ec2_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Effect    = "Allow"
        Principal = { Service = "ec2.amazonaws.com" }
      }
    ]
  })

  tags = {
    Name = "k3s_ec2_role"
  }
}

#########################
# IAM Policy (CloudWatch & S3 access)
#########################

resource "aws_iam_policy" "ec2_policy" {
  name        = "k3s_ec2_policy"
  description = "Allows EC2 to write logs to CloudWatch and access S3 for K3s artifacts"
  
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
      {
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:ListBucket"
        ]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}

#########################
# Attach Policy to Role
#########################
resource "aws_iam_role_policy_attachment" "ec2_attach_policy" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = aws_iam_policy.ec2_policy.arn
}

#########################
# Instance Profile
#########################
resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "k3s_ec2_instance_profile"
  role = aws_iam_role.ec2_role.name
}
