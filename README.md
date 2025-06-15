---

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


---

🔧 Tools & Technologies

Tool	Purpose

Terraform	Infrastructure provisioning (EKS, VPC, etc.)
Jenkins	CI pipeline to build/test/push Docker images
Docker	Containerization
ArgoCD	GitOps-based CD
Prometheus	Monitoring (basic setup)
Kubernetes	Application orchestration
AWS (EKS)	Managed Kubernetes Cluster
GitHub	Source control



---

🚀 CI/CD Pipeline Flow

1. Developer pushes code to GitHub.


2. Jenkins Pipeline is triggered.


3. Stages in Jenkins:

Build & install dependencies

Code quality analysis using SonarQube

Image scan using Trivy

Build & push Docker images to Docker Hub

Update Kubernetes manifests in GitHub



4. ArgoCD watches the repo and deploys the updated manifests to the EKS cluster.




---

⚙️ How to Run Locally

> Prerequisites:



AWS CLI configured

kubectl

Terraform

Jenkins (or use Jenkins container)

ArgoCD (optional local or via Helm on EKS)

Docker


1. Provision Infrastructure

cd terraform/
terraform init
terraform apply

2. Deploy Kubernetes Manifests

cd kubernetes/
kubectl apply -f .

3. Access the App

Once the LoadBalancer (Ingress) is provisioned, you can access the app via its external IP.


---

📈 Monitoring

Prometheus is deployed inside the cluster to monitor Kubernetes nodes and pods.

Basic Node Exporter configuration is used.



---

📄 Notes

Avoid committing secrets or .tfstate files.

Use .tfvars for environment-specific configuration.

You can extend the system with Grafana, ELK Stack, etc.



---

👨‍💻 Author

Amr Hatem
DevOps Engineer


