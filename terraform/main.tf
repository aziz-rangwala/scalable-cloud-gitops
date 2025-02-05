terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source = "./modules/vpc"
  
  vpc_cidr        = var.vpc_cidr
  cluster_name    = var.cluster_name
  aws_region      = var.aws_region
  
  tags = var.tags
}

module "iam" {
  source = "./modules/iam"
  
  cluster_name = var.cluster_name
  tags        = var.tags
}

module "eks_cluster" {
  source = "./modules/eks-cluster"
  
  cluster_name     = var.cluster_name
  vpc_id           = module.vpc.vpc_id
  private_subnets  = module.vpc.private_subnets
  cluster_role_arn = module.iam.cluster_role_arn
  node_role_arn    = module.iam.node_role_arn
  
  node_group_config = {
    desired_size    = 3
    min_size        = 1
    max_size        = 10
    instance_types  = ["t3.medium", "t3.large"]
  }
  
  tags = var.tags
} 