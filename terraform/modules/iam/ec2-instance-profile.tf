resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "k3s-ec2-instance-profile"
  role = aws_iam_role.ec2_role.name
}
