#!/bin/bash
set -e

REMOTE_USER=ubuntu
REMOTE_KUBECONFIG_PATH="/etc/rancher/k3s/k3s.yaml"
LOCAL_KUBECONFIG_PATH="./kubeconfig.yaml"

scp \
  -o ProxyJump=ubuntu@${BASTION_IP} \
  -i "${SSH_KEY}" \
  ubuntu@${PRIVATE_IP}:${REMOTE_KUBECONFIG_PATH} \
  ${LOCAL_KUBECONFIG_PATH}

sed -i "s/127.0.0.1/${BASTION_IP}/g" ${LOCAL_KUBECONFIG_PATH}

chmod 600 ${LOCAL_KUBECONFIG_PATH}

echo "✅ kubeconfig exported securely via bastion"
echo "👉 export KUBECONFIG=$(pwd)/kubeconfig.yaml"
