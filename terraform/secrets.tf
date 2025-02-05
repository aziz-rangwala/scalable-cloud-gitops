data "aws_secretsmanager_secret" "eks_secrets" {
  name = "eks-cluster-secrets"
}

data "aws_secretsmanager_secret_version" "current" {
  secret_id = data.aws_secretsmanager_secret.eks_secrets.id
}

locals {
  secrets = jsondecode(data.aws_secretsmanager_secret_version.current.secret_string)
} 