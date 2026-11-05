variable "cluster_name" {
  description = "EKS cluster name, also used as the SQS queue name"
  type        = string
}

variable "tags" {
  description = "Common tags applied to resources"
  type        = map(string)
  default     = {}
}

variable "cluster_arn" {
  description = "ARN of the EKS cluster"
  type        = string
}

variable "oidc_provider_arn" {
  description = "ARN of the cluster's OIDC provider (for IRSA)"
  type        = string
}

variable "oidc_issuer_url" {
  description = "OIDC issuer URL of the cluster (for IRSA)"
  type        = string
}
