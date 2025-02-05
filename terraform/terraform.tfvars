aws_region   = "us-west-2"
cluster_name = "demo-eks-cluster"
vpc_cidr     = "10.0.0.0/16"
environment  = "dev"

tags = {
  Environment = "dev"
  Terraform   = "true"
  Project     = "auto-scaling-demo"
  Owner       = "your-name"
} 