variable "aws_region" {
  description = "AWS region to deploy resources into"
  type        = string
  default     = "us-east-1"
}
variable "haproxy_instance_type" {
  type    = string
  default = "t3.small"
}

variable "k3s_instance_type" {
  type    = string
  default = "t3.medium"
}
