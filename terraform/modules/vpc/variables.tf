variable "cluster_name" {
  type        = string
  description = "Name of the EKS cluster for naming and tagging"
}

variable "aws_region" {
  type        = string
  description = "AWS region for availability zones"
}


variable "public_subnet_tags" {
  description = "Extra tags for public subnets (e.g. ALB controller role tags), set by the caller"
  type        = map(string)
  default     = {}
}

variable "private_subnet_tags" {
  description = "Extra tags for private subnets (e.g. Karpenter discovery, internal ALB), set by the caller"
  type        = map(string)
  default     = {}
}
