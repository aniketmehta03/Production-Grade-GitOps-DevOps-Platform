# 🚀 Production-Grade DevOps CRUD Application (Ubuntu Setup)

## 🎯 Problem Statement

Design, build, containerize, deploy, automate, operate, and monitor a **production-grade CRUD web application** using modern DevOps practices.

The system must be:

- ✅ Fully Containerized
- ✅ Kubernetes Deployed
- ✅ Helm Managed
- ✅ CI/CD Automated
- ✅ GitOps Controlled
- ✅ Cloud Provisioned using Terraform
- ✅ Fully Monitored using Prometheus, Grafana & Loki

---

# 🧱 Application Requirements

## 1️⃣ Application Layer

Build a CRUD application:

- Backend: Node.js / Python / Go
- Frontend: Optional (UI or API-only)
- Database: PostgreSQL

### Features

- Create record
- Read record
- Update record
- Delete record
- Persistent database storage

### Expose

- REST APIs

---

# 🐳 Containerization Layer

## 2️⃣ Docker

Requirements:

- Multi-stage Dockerfile
- Alpine base images
- Use `.dockerignore`
- Use ENV variables for configs
- Run as non-root user
- Small optimized image size

---

# 🧩 Local Orchestration

## 3️⃣ Docker Compose

Create `docker-compose.yaml` including:

- backend
- postgres

Must include:

- volumes
- networks
- environment variables
- depends_on

Support:

- Hot reload development mode


---

# ☸️ Kubernetes Layer

## 5️⃣ Kubernetes

Write YAML manifests for:

- Backend Deployment
- PostgreSQL StatefulSet + PVC
- Services
- Ingress

Use:

- Secrets
- ConfigMaps

Must demonstrate:

- Scaling
- Rollbacks
- Zero downtime rollout

---

# 📦 Helm Layer

## 6️⃣ Helm

Create a generic Helm chart:

- Capable of deploying ANY backend

Convert:

- All Kubernetes YAML → Helm templates

Use:

- values.yaml
- Environment-specific values files

---

# 🔁 CI/CD Automation

## 7️⃣ GitHub Actions

### Pipeline A (main branch)

- Build Docker image
- Tag image
- Push to DockerHub / ECR

### Pipeline B (feat/* or Dockerfile change)

- Build new image
- Push image
- Auto-update `helm/values.yaml` image tag
- Commit changes back to repo

---

# 🔄 GitOps Deployment

## 8️⃣ ArgoCD

Install ArgoCD using YAML.

Create:

- ArgoCD Project
- ArgoCD Application

ArgoCD must:

- Auto Sync
- Auto Heal
- Auto Rollback

❌ No manual `kubectl apply` allowed

---

# ☁️ Infrastructure as Code

## 9️⃣ Terraform

Provision:

- VPC
- Subnets
- Internet Gateway
- NAT Gateway
- EC2
- S3
- IAM Role
- ECR
- EKS or ECS

Must use:

- Terraform Modules
- Remote State (S3 + DynamoDB)
- Variables

---

# 📊 Observability Stack

## 🔟 Monitoring

Install using Helm:

- Prometheus
- Grafana
- Loki

Must display:

- CPU usage
- Memory usage
- Pod count
- Application logs

Create Alerts:

- High CPU usage
- Pod crash

---

# 📐 Architecture & Documentation

## 1️⃣1️⃣ Required Deliverables

You must submit:

- Architecture Diagram
- CI/CD Flow Diagram
- GitOps Flow Diagram
- Incident Response Documentation

---

# 🏁 Final Output Expectations

```
Git Push
   ↓
CI Pipeline
   ↓
Docker Image Build
   ↓
Helm Values Update
   ↓
Kubernetes Deployment
   ↓
Metrics & Logs Visible
```
