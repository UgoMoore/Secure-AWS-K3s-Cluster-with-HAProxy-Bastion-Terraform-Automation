output "haproxy_public_ip" {
  description = "Public IP address of the HAProxy bastion host"
  value       = aws_instance.haproxy.public_ip
}

output "k3s_private_ip" {
  description = "Private IP address of the K3s server node"
  value       = aws_instance.k3s.private_ip
}

output "k3s_cluster_endpoint" {
  description = "Kubernetes API endpoint exposed via HAProxy"
  value       = aws_instance.haproxy.public_ip
}
