# ITI DevOps Project

This project demonstrates the deployment of a fully managed **Kubernetes (EKS)** cluster on **AWS** using **Terraform**, along with application workloads and observability tooling like **Prometheus**, **Grafana**, and **Alertmanager**.

---

## 📁 Project Structure

### Terraform Modules (`/modules`)
- `IAMROLE`: IAM role setup for EKS components
- `SGCONTROLPLAN`: Security group for the EKS control plane
- `SGNODES`: Security group for worker nodes
- `SGRULE`: Security group rules
- `EKSCLUSTER`: EKS cluster creation
- `INTERNETGATEWAY`: Provides internet access to the VPC
- `NODEROLE`: IAM role for node groups
- `NODESGROUP`: EKS managed node group setup
- `SUBNETS`: Subnet provisioning across availability zones
- `BBC`: (Name unclear — possibly a VPC or NAT-related module)

### Kubernetes Manifests
Located in the root folders:
- `ALERTMANAGER/`: Configuration for Alertmanager
- `BACKEND/`: Backend app deployment
- `DATABASE/`: DB deployment (likely PostgreSQL or MySQL)
- `FRONTEND/`: Frontend app deployment
- `GRAFANA/`: Grafana setup and dashboards
- `INGRESS RESOURCES/`: Ingress controllers and ingress rules
- `KUBE STATE METRICS/`: Kubernetes metrics exporter
- `NODE EXPORTER/`: Node-level metrics collection
- `PROMETHEUS SERVER/`: Prometheus server deployment and configuration

---

## ⚙️ Infrastructure Setup

1. **Initialize Terraform**
   ```bash
   terraform init
