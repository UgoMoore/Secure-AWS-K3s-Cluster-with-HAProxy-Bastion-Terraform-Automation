#!/bin/bash
set -e

# Install K3s
curl -sfL https://get.k3s.io | sh -

# Wait for K3s to be ready
sleep 30

# Metrics Server
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml

# KubeAudit
curl -s https://raw.githubusercontent.com/Shopify/kubeaudit/master/install | bash

# CloudWatch agent
/bin/bash ${path.module}/scripts/cloudwatch_install.sh

echo "✅ K3s installed, Metrics Server, KubeAudit, and CloudWatch agent configured"
