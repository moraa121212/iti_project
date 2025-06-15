---

# ITI DevOps Project 🚀

This project demonstrates the deployment of a fully managed **Kubernetes (EKS)** cluster on **AWS** using **Terraform**. It includes application workloads and observability tooling like **Prometheus**, **Grafana**, and **Alertmanager**.

## Table of Contents 📚
- [Project Overview](#project-overview)
- [Features](#features)
- [Project Structure](#project-structure)
- [Infrastructure Setup](#infrastructure-setup)
- [Usage](#usage)
- [Contributing](#contributing)
- [License](#license)
- [Contact](#contact)

## Project Overview 🌟
This project aims to automate the deployment and management of cloud infrastructure using Infrastructure as Code (IaC). By leveraging Terraform and Kubernetes, it provides a scalable, reliable, and efficient environment for running containerized applications.

## Features 🛠️
- **Fully Managed EKS Cluster**: Simplifies Kubernetes cluster management.
- **Infrastructure as Code**: Uses Terraform for reproducible infrastructure.
- **Observability**: Integrates Prometheus for monitoring and Grafana for visualization.
- **Scalability**: Easily scale applications with Kubernetes.
- **Security**: Configured IAM roles and security groups for secure access.

## Project Structure 📂
### Terraform Modules (`/modules`)
- **IAMROLE**: IAM role setup for EKS components.
- **SG-CONTROL-PLANE**: Security group for the EKS control plane.
- **SG-NODES**: Security group for worker nodes.
- **SG-RULE**: Security group rules.
- **EKS-CLUSTER**: EKS cluster creation.
- **INTERNET-GATEWAY**: Provides internet access to the VPC.
- **NODE-ROLE**: IAM role for node groups.
- **NODES-GROUP**: EKS managed node group setup.
- **SUBNETS**: Subnet provisioning across availability zones.

### Kubernetes Manifests (Located in root folders)
- **ALERTMANAGER/**: Configuration for Alertmanager.
- **BACKEND/**: Backend application deployment.
- **DATABASE/**: Database deployment (likely PostgreSQL or MySQL).
- **FRONTEND/**: Frontend application deployment.
- **GRAFANA/**: Grafana setup and dashboards.
- **INGRESS RESOURCES/**: Ingress controllers and ingress rules.
- **KUBE STATE METRICS/**: Kubernetes metrics exporter.
- **NODE EXPORTER/**: Node-level metrics collection.
- **PROMETHEUS SERVER/**: Prometheus server deployment and configuration.

## Infrastructure Setup ⚙️
To set up the infrastructure, follow these steps:

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/moraa121212/iti_project.git
   cd iti_project
   ```

2. **Initialize Terraform**:
   ```bash
   terraform init
   ```

3. **Plan the Deployment**:
   ```bash
   terraform plan
   ```

4. **Apply the Deployment**:
   ```bash
   terraform apply
   ```

## Usage 💻
After deploying, you can access the applications via the configured endpoints. Use Grafana to visualize metrics collected by Prometheus.

## Contributing 🤝
Contributions are welcome! Please fork the repository and submit a pull request. Ensure that your code adheres to the project's coding standards.

## License 📜
This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Contact 📧
For any inquiries, please reach out to:
- **Author**: [moraa121212]
- **Email**: amr.hatem2h@gmail.com

---
