output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_id" {
  value = module.vpc.public_subnet_id
}

output "private_subnet_id" {
  value = module.vpc.private_subnet_id
}

output "haproxy_public_ip" {
  value = module.k3s_haproxy.haproxy_public_ip
}

output "k3s_private_ip" {
  value = module.k3s_haproxy.k3s_private_ip
}


