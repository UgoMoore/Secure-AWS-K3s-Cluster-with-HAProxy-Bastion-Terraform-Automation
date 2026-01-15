variable "ec2_instance_profile_name" {
  description = "IAM Instance Profile Name for EC2"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "public_subnet_id" {
  description = "Public subnet ID for HAProxy"
  type        = string
}

variable "private_subnet_id" {
  description = "Private subnet ID for K3s"
  type        = string
}

variable "ami_id" {
  description = "AMI ID for EC2 instances"
  type        = string
}

variable "haproxy_instance_type" {
  description = "Instance type for HAProxy bastion"
  type        = string
}

variable "k3s_instance_type" {
  description = "Instance type for K3s server"
  type        = string
}

variable "key_name" {
  description = "SSH key pair name"
  type        = string
}

variable "ssh_private_key_path" {
  description = "Local path to SSH private key"
  type        = string
}

variable "iam_instance_profile" {
  description = "IAM instance profile for EC2"
  type        = string
}
