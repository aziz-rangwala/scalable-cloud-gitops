variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "private_subnets" {
  description = "List of private subnet IDs"
  type        = list(string)
}

variable "cluster_role_arn" {
  description = "ARN of the EKS cluster IAM role"
  type        = string
}

variable "node_role_arn" {
  description = "ARN of the EKS node IAM role"
  type        = string
}

variable "node_group_config" {
  description = "Configuration for the node group"
  type = object({
    desired_size = number
    min_size     = number
    max_size     = number
    instance_types = list(string)
  })
  default = {
    desired_size = 3
    min_size     = 1
    max_size     = 10
    instance_types = ["t3.medium", "t3.large"]
  }
}

variable "tags" {
  description = "Resource tags"
  type        = map(string)
  default     = {}
} 