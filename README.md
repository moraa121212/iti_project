# ITI DevOps Project

This repository contains a complete DevOps pipeline for deploying a 3-Tier Web Application (Frontend, Backend, Database) on AWS using Kubernetes (EKS). It automates CI/CD, infrastructure provisioning, monitoring, and GitOps.

---

## 🌐 Project Overview

**Architecture Includes:**
- AWS EKS Cluster for Kubernetes workloads
- Terraform for Infrastructure as Code (IaC)
- Jenkins for CI Pipeline
- ArgoCD for CD (GitOps)
- Docker for containerization
- Prometheus for monitoring
- GitHub for source control

---

## 📦 Project Structure

```bash
├── terraform/                   # All Terraform IaC modules
│   ├── eks/                     # EKS cluster creation
│   ├── vpc/                     # Network resources (VPC, subnets, gateways)
│   └── security-groups/        # SG rules
│
├── kubernetes/                 # K8s manifests
│   ├── frontend/               # Deployment & Service for frontend
│   ├── backend/                # Deployment & Service for backend
│   ├── database/               # DB deployment (optional - internal)
│   └── secrets/                # Kubernetes secrets
│
├── jenkins/                    # Jenkins pipeline definition
│   └── Jenkinsfile
│
├── docker/                     # Dockerfiles for both frontend & backend
│   ├── frontend/
│   └── backend/
│
└── README.md
