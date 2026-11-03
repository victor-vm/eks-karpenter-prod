variable "cluster_name" {
  type        = string
  description = "Name of the EKS cluster"
  default     = "eks-karpenter-sandbox"
}

variable "aws_region" {
  type        = string
  description = "AWS region for deployment"
  default     = "ap-south-1"
}

variable "allowed_instance_types" {
  type        = list(string)
  description = "List of free-tier and low-cost instance types allowed for Karpenter scaling"
  default     = ["t3.micro", "t3.small", "t4g.micro", "t4g.small"]
}


variable "bootstrap_instance_types" {
  type        = list(string)
  description = "x86-only instance types for the bootstrap node group (must match its AL2023 x86 AMI)"
  default     = ["t3.small"] # changed from ["t3.micro", "t3.small"]
}