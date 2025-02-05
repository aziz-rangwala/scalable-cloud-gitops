# Auto-Scaling GitOps Demo

This project demonstrates a complete GitOps-based infrastructure setup with auto-scaling capabilities on AWS EKS.

## Architecture

- **Infrastructure**: AWS EKS with spot instances for cost optimization
- **GitOps**: ArgoCD for continuous deployment
- **Monitoring**: Prometheus & Grafana
- **CI/CD**: GitHub Actions with security scanning
- **Auto-scaling**: Horizontal Pod Autoscaling (HPA)

## Prerequisites

- AWS CLI v2
- Terraform >= 1.0
- kubectl
- Helm v3
- Docker
- GitHub account
- Docker Hub account

## Quick Start

1. **Configure AWS Credentials**

```bash
aws configure
```

2. **Deploy Infrastructure**

```bash
cd terraform
terraform init
terraform apply
```

3. **Configure kubectl**
```bash
aws eks update-kubeconfig --name demo-eks-cluster --region us-west-2
```

4. **Install ArgoCD**
```bash
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
```

5. **Deploy Application**
```bash
kubectl apply -f kubernetes/config/app-config.yaml
kubectl create secret generic app-secrets --from-literal=DB_PASSWORD='your-password' \
  --from-literal=API_KEY='your-api-key' --from-literal=JWT_SECRET='your-jwt-secret'
```

## Repository Structure

```
auto-scaling-gitops-demo/
├── terraform/               # Cloud infrastructure
├── kubernetes/             # K8s manifests
├── ci-cd/                  # CI/CD workflows
├── sample-app/             # Demo application
└── docs/                   # Documentation
```

## Configuration

1. **Infrastructure Variables**: Update `terraform/terraform.tfvars`
2. **GitHub Secrets**:
   - `DOCKERHUB_USERNAME`
   - `DOCKERHUB_TOKEN`
3. **Application Config**: Update `kubernetes/config/app-config.yaml`

## Testing Auto-scaling

Generate load to test HPA:
```bash
kubectl run -i --tty load-generator --rm --image=busybox --restart=Never -- /bin/sh -c \
  "while sleep 0.01; do wget -q -O- http://sample-app-service/load; done"
```

## Monitoring

Access Grafana dashboard:
```bash
kubectl port-forward svc/prometheus-server 8080:80 -n monitoring
```

## Cleanup

```bash
# Delete application resources
kubectl delete -f kubernetes/

# Destroy infrastructure
cd terraform
terraform destroy
```

