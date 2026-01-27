variable "vpc_id" {
  description = "VPC ID where instances will be launched"
  type        = string
}

variable "public_subnet_id" {
  description = "Public subnet ID for HAProxy/Bastion"
  type        = string
}

variable "private_subnet_id" {
  description = "Private subnet ID for K3s server"
  type        = string
}

variable "ami_id" {
  description = "AMI ID for EC2 instances"
  type        = string
}

variable "haproxy_instance_type" {
  description = "EC2 instance type for HAProxy bastion host"
  type        = string
  default     = "t3.small"
}

variable "k3s_instance_type" {
  description = "EC2 instance type for K3s server"
  type        = string
  default     = "t3.medium"
}

variable "key_name" {
  description = "AWS EC2 SSH key pair name"
  type        = string
}

variable "ssh_private_key_path" {
  description = "Local path to SSH private key"
  type        = string
}
