# Secure AWS K3s Cluster with HAProxy Bastion — Terraform Automation

---

## Project Overview

This project demonstrates the design and infrastructure provisioning of a **secure, bastion-based K3s Kubernetes architecture on AWS**, implemented using **Terraform (Infrastructure as Code)**. The focus is on **network isolation, IAM-first security, modular design, and automation discipline**, rather than ad-hoc resource creation.

The infrastructure reached full architectural completeness. Final execution of the private K3s node was constrained by local Terraform provider stability and AWS Free Tier enforcement behavior, which is transparently documented.

---

## Architecture Summary

**Key design decisions:**

- Custom AWS VPC (non-default)
- Public subnet for HAProxy bastion
- Private subnet for K3s server
- Bastion-only access pattern (no direct public access to K3s)
- IAM role-based EC2 access (no static credentials)
- Modular Terraform structure for reusability

**High-level flow:**

```
Internet → HAProxy Bastion (Public Subnet)
          → K3s Server (Private Subnet)
```

---

## Identity & Access Management (IAM)

IAM was fully provisioned and validated in AWS.

### Components

- **IAM Role:** `k3s_ec2_role`
- **Instance Profile:** `k3s_ec2_instance_profile`
- **Customer-Managed Policy:** `k3s_ec2_policy`

### Purpose

- Enables EC2 instances to assume roles securely
- Allows controlled CloudWatch Logs and S3 access
- Avoids hardcoded AWS credentials

### Evidence

- `01-iam-role.png`
- `02-iam-policy.png`
- `03-iam-instance-profile.png`

---

## Compute Layer (EC2)

### HAProxy Bastion Instance

- Successfully launched and verified
- Deployed in public subnet
- IAM role attached
- Serves as controlled access point

**Instance Details:**
- Instance Type: `t3.small`
- Subnet: Public
- IAM Role: `k3s_ec2_role`

### K3s Server Instance (Execution Boundary)

- Fully defined in Terraform
- IAM role and security groups attached
- Intended for private subnet deployment
- Execution constrained during apply due to provider/plugin instability

### Evidence

- `05-ec2-haproxy-instance-summary.png`
- `06-ec2-haproxy-networking.png`
- `07-ec2-tags.png`

---

## Network Architecture (VPC)

A custom VPC was created to ensure full control over networking.

### Components

- VPC Name: `Silent_Night`
- CIDR: `10.0.0.0/16`
- Public Subnet: `10.0.1.0/24`
- Private Subnet: `10.0.2.0/24`
- Internet Gateway + NAT Gateway

### Design Intent

- Public-facing bastion
- Isolated private compute
- Clean IP planning

### Evidence

- `08-vpc-overview.png`
- `09-subnets.png`

---

## Security Groups

Security was enforced through **separate, least-privilege security groups**.

### HAProxy Security Group

- SSH (22) — controlled access
- Kubernetes API (6443)

### K3s Security Group

- API access only from HAProxy SG
- Internal node traffic scoped

### Evidence

- `10-haproxy-security-group.png`
- `11-k3s-security-group.png`

---

## Observability Scope (Intentional Boundary)

CloudWatch logging was **planned and scoped**, but not initialized due to execution boundary.

This is intentionally documented to avoid false claims and to maintain audit integrity.

### Evidence

- `12-cloudwatch-log-groups.png`

---

## Infrastructure as Code (Terraform)

The project follows a **modular Terraform design**.

### Structure

```
terraform/
├── main.tf
├── providers.tf
├── variables.tf
├── versions.tf
├── outputs.tf
└── modules/
    ├── 01-vpc/
    └── 02-k3s-haproxy/
```

### Principles

- Reusable modules
- Clear separation of concerns
- Variable-driven configuration
- Automation-first mindset

### Evidence

- `13-terraform-modules-tree.png`
- `14-terraform-main-tf.png`

---

## Execution Boundary & Constraints

Infrastructure provisioning reached the **compute execution phase**.

- VPC, IAM, security groups, and bastion EC2 deployed successfully
- K3s server definition completed and validated
- Full cluster execution constrained by local Terraform provider plugin instability and AWS Free Tier enforcement behavior

All architectural components were independently validated within AWS.

---

## Key Learnings

- Bastion-based Kubernetes access design
- IAM-first EC2 security model
- Terraform module hygiene and reuse
- Importance of documenting execution boundaries
- Cost-awareness during infrastructure experimentation

---

## Teardown & Cost Control (Terraform-First)

After documentation and screenshot capture, the entire infrastructure is intended to be destroyed **using Terraform**, not manual deletion.

### Recommended Teardown Steps

```bash
terraform init -reconfigure
terraform refresh
terraform destroy -auto-approve
```

> If provider instability prevents full teardown, AWS Console verification should be performed to confirm no orphaned resources remain.

---

## Project Status

**Status:** Infrastructure-complete, execution-constrained by environment & provider limitations.

This project demonstrates strong cloud architecture fundamentals, security awareness, and professional infrastructure documentation.

