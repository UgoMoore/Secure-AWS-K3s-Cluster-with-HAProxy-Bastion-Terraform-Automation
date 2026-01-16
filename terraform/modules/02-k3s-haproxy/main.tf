resource "aws_instance" "haproxy_bastion" {
  ami           = var.ami_id
  instance_type = var.haproxy_instance_type
  subnet_id     = var.public_subnet_id
  key_name      = var.key_name

  iam_instance_profile = aws_iam_instance_profile.ec2_instance_profile.name

  user_data = file("${path.module}/scripts/haproxy_user_data.sh")

  tags = { Name = "HAProxy-Bastion" }
}

resource "aws_instance" "k3s" {
  ami           = var.ami_id
  instance_type = var.k3s_instance_type
  subnet_id     = var.private_subnet_id
  key_name      = var.key_name

  iam_instance_profile = aws_iam_instance_profile.ec2_instance_profile.name

  user_data = file("${path.module}/scripts/k3s_user_data.sh")

  tags = { Name = "K3s-Server" }
}

