#!/bin/bash
set -e

apt update -y
apt install -y haproxy openssl

# Self-signed TLS certificate
mkdir -p /etc/ssl/private
openssl req -x509 -nodes -days 365 \
  -subj "/CN=k3s.example.com" \
  -newkey rsa:2048 \
  -keyout /etc/ssl/private/haproxy.key \
  -out /etc/ssl/private/haproxy.crt

cat /etc/ssl/private/haproxy.crt /etc/ssl/private/haproxy.key > /etc/ssl/private/haproxy.pem

# HAProxy configuration
cat <<EOF > /etc/haproxy/haproxy.cfg
global
  log /dev/log local0
  maxconn 2048
defaults
  mode tcp
  timeout connect 5s
  timeout client 30s
  timeout server 30s
frontend k8s_api
  bind *:6443 ssl crt /etc/ssl/private/haproxy.pem
  default_backend k3s_backend
backend k3s_backend
  server k3s_node ${PRIVATE_IP}:6443 check
EOF

systemctl enable haproxy
systemctl restart haproxy

echo "✅ HAProxy installed with TLS on 6443"
