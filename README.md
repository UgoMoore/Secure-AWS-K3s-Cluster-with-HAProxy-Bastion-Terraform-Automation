# Secure AWS K3s Cluster with HAProxy Bastion (Terraform Automation)

A production-style, security-focused Kubernetes (K3s) deployment on AWS, fully automated with Terraform.  
This project demonstrates secure-by-design cloud infrastructure, bastion-based access control, and Infrastructure as Code (IaC) best practices.

---

## Project Overview

This project provisions a **secure single-node K3s Kubernetes cluster on AWS**, fronted by an **HAProxy bastion host** for controlled access.  
All infrastructure is defined and deployed using **Terraform**, emphasizing automation, least privilege, and defense-in-depth.

The architecture mirrors real-world cloud security patterns used in DevSecOps and platform engineering environments.

---

## Architecture Summary

- AWS VPC with public and private subnets
- HAProxy Bastion Host (Public Subnet)
  - Acts as controlled entry point
  - Proxies Kubernetes API traffic
- K3s Server Node (Private Subnet)
  - No public IP exposure
  - Accessible only via bastion
- NAT Gateway for outbound access from private subnet
- Terraform remote backend for state management

---

## Security Design Principles

- Principle of Least Privilege (SG-to-SG access)
- No direct SSH access to private nodes
- Bastion-host-only Kubernetes API exposure
- Private subnet isolation
- Automated provisioning (no manual drift)
- Infrastructure-as-Code security controls

---

## Key Features

- Fully automated Terraform deployment
- Secure bastion-based access pattern
- HAProxy TCP load balancing for Kubernetes API
- Private K3s node with no public exposure
- Automated kubeconfig export
- Modular, reusable Terraform structure
- Portfolio-ready documentation

---

## Project Structure

```text
Secure-AWS-K3s-Cluster-with-HAProxy-Bastion/
│
├── backend.tf
├── providers.tf
├── variables.tf
├── outputs.tf
│
├── 01-vpc/
│   └── main.tf
│
├── 02-k3s-haproxy/
│   ├── main.tf
│   ├── scripts/
│   │   ├── k3s_install.sh
│   │   └── kubeconfig_export.sh
│
├── scripts/
│   └── cleanup.sh
│
├── .gitignore
└── README.md
```

---

## Deployment Workflow

### 1️⃣ Prerequisites

- AWS Account
- AWS CLI configured
- Terraform ≥ v1.5
- SSH key pair created in AWS
- VS Code (recommended)

---

### 2️⃣ Initialize Terraform

```bash
terraform init
```

---

### 3️⃣ Validate Configuration

```bash
terraform validate
```

---

### 4️⃣ Deploy Infrastructure

```bash
terraform apply
```

Confirm with `yes` when prompted.

---

### 5️⃣ Access the Cluster

- Kubeconfig is automatically exported
- Access is routed securely via the HAProxy bastion
- Manage cluster using:
  - kubectl
  - OpenLens
  - Kubernetes CLI tools

---

## Verification

```bash
kubectl get nodes
kubectl get pods -A
```

Expected result:
- One healthy K3s node
- System pods running successfully

---

## Tools & Technologies

- **Cloud:** AWS (EC2, VPC, Subnets, NAT Gateway)
- **Kubernetes:** K3s
- **IaC:** Terraform
- **Networking:** HAProxy
- **Automation:** Bash
- **Security:** Bastion access, SG isolation
- **Tooling:** OpenLens, kubectl, VS Code

---

## Learning Outcomes

- Designed secure cloud-native Kubernetes architecture
- Implemented bastion-based access controls
- Applied Terraform automation best practices
- Strengthened understanding of Kubernetes security
- Built a recruiter-ready DevSecOps portfolio project

---

## Portfolio Context

This project is part of my **Cloud Security & DevSecOps portfolio**, showcasing real-world infrastructure automation, Kubernetes security, and AWS best practices.

---

## ⚠️ Disclaimer

This project is intended for **educational and portfolio purposes**.  
Do not deploy to production without additional hardening, monitoring, and compliance controls.
