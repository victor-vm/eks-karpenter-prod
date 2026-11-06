variable "cluster_name" {
  description = "EKS cluster name, passed to the controller so it knows which cluster it manages"
  type        = string
}

variable "oidc_provider_arn" {
  description = "ARN of the cluster's IAM OIDC provider, used in the IRSA trust policy"
  type        = string
}

variable "oidc_issuer_url" {
  description = "OIDC issuer URL of the cluster (with https://), used to scope the trust policy to one service account"
  type        = string
}

variable "vpc_id" {
  description = "VPC the controller creates load balancers in"
  type        = string
}

variable "aws_region" {
  description = "AWS region of the cluster"
  type        = string
}

variable "tags" {
  description = "Tags applied to the IAM resources"
  type        = map(string)
  default     = {}
}
