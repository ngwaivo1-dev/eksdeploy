# EKSDeploy 🚀

A production-style DevOps project that deploys a containerized Flask application 
to AWS EKS using Terraform, Docker, and Kubernetes.

## Architecture
```
Flask App → Docker Image → AWS ECR → AWS EKS → Load Balancer → Internet
```

## Tech Stack

| Tool | Purpose |
|---|---|
| **Terraform** | Provision AWS infrastructure (VPC, EKS, ECR) |
| **Docker** | Containerize the Flask application |
| **AWS ECR** | Store Docker images |
| **AWS EKS** | Run and manage Kubernetes workloads |
| **Kubernetes** | Deploy and scale the application |
| **AWS Load Balancer** | Expose the app publicly |

## Infrastructure

- VPC with public and private subnets across 2 availability zones
- EKS Cluster (Kubernetes 1.32) with 2 t3.medium worker nodes
- ECR repository for Docker image storage
- NAT Gateway for private subnet internet access

## Project Structure
```
eksdeploy/
├── terraform/
│   ├── main.tf          # VPC, EKS, ECR resources
│   ├── variables.tf     # Input variables
│   ├── outputs.tf       # Output values
│   └── versions.tf      # Provider versions
├── app/
│   ├── app.py           # Flask application
│   └── requirements.txt # Python dependencies
├── k8s/
│   ├── deployment.yaml  # Kubernetes deployment
│   └── service.yaml     # Kubernetes load balancer service
└── Dockerfile           # Container image definition
```

## Prerequisites

- AWS CLI configured
- Terraform >= 1.0
- Docker
- kubectl

## Usage

### 1. Provision Infrastructure
```bash
cd terraform
terraform init
terraform apply
```

### 2. Configure kubectl
```bash
aws eks update-kubeconfig --region eu-central-1 --name eksdeploy-cluster
```

### 3. Build and Push Docker Image
```bash
aws ecr get-login-password --region eu-central-1 | docker login --username AWS \
--password-stdin <your-ecr-url>
docker build -t eksdeploy-app .
docker tag eksdeploy-app:latest <your-ecr-url>/eksdeploy-app:latest
docker push <your-ecr-url>/eksdeploy-app:latest
```

### 4. Deploy to Kubernetes
```bash
kubectl apply -f k8s/
kubectl get pods
kubectl get service helloops-service
```

### 5. Destroy Infrastructure
```bash
cd terraform
terraform destroy
```

## Author
Ngwa — DevOps Engineer in progress 🚀