# ---------------------------
# HAProxy (Bastion)
# ---------------------------
resource "aws_instance" "haproxy_bastion" {
  ami                         = var.ami_id
  instance_type               = var.haproxy_instance_type
  key_name                    = var.key_name
  subnet_id                   = var.public_subnet_id
  vpc_security_group_ids      = [aws_security_group.haproxy_sg.id]
  associate_public_ip_address = true
  iam_instance_profile        = aws_iam_instance_profile.ec2_instance_profile.name

  tags = {
    Name = "haproxy-bastion"
  }

  user_data = <<-EOF
              #!/bin/bash
              echo "Setting up HAProxy as K8s API load balancer"
              EOF
}

# ---------------------------
# K3s Node
# ---------------------------
resource "aws_instance" "k3s_server" {
  ami                         = var.ami_id
  instance_type               = var.k3s_instance_type
  key_name                    = var.key_name
  subnet_id                   = var.private_subnet_id
  vpc_security_group_ids      = [aws_security_group.k3s_sg.id]
  associate_public_ip_address = false
  iam_instance_profile        = aws_iam_instance_profile.ec2_instance_profile.name

  tags = {
    Name = "k3s-server"
  }

  user_data = <<-EOF
              #!/bin/bash
              echo "Setting up K3s server"
              EOF
}
