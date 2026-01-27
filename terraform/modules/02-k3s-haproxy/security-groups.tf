resource "aws_security_group" "haproxy_sg" {
  name        = "haproxy-bastion-sg"
  description = "Allow SSH and K8s API via HAProxy"
  vpc_id      = var.vpc_id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Kubernetes API"
    from_port   = 6443
    to_port     = 6443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "haproxy-bastion-sg"
  }
}

resource "aws_security_group" "k3s_sg" {
  name        = "k3s-server-sg"
  description = "Allow K3s internal traffic"
  vpc_id      = var.vpc_id

  ingress {
    description     = "K3s API from HAProxy"
    from_port       = 6443
    to_port         = 6443
    protocol        = "tcp"
    security_groups = [aws_security_group.haproxy_sg.id]
  }

  ingress {
    description = "Node internal traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    self        = true
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "k3s-server-sg"
  }
}


