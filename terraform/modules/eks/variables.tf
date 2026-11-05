# The name of the EKS cluster. Passed in from root so this module isn't
# hardcoded to one specific cluster name — reusable for dev/staging/prod.
variable "cluster_name" {
  type        = string
  description = "Name of the EKS cluster"
}

# The ARN of the IAM role the EKS control plane will assume (from iam-cluster.tf
# at root). The module can't reach root-level resources directly, so this
# value must be handed in as an input.
variable "cluster_role_arn" {
  type        = string
  description = "ARN of the IAM role the EKS cluster will assume"
}

# The Kubernetes version for the control plane (e.g. "1.34"). Kept as a
# variable so upgrading versions later is a one-line change at root,
# not a dig through module internals.
variable "cluster_version" {
  type        = string
  description = "Kubernetes version for the control plane"
}

# The subnet IDs the EKS control plane's network interfaces live in.
# These come from your VPC module's outputs (private_subnet_ids,
# public_subnet_ids), passed through root into this module.
variable "subnet_ids" {
  type        = list(string)
  description = "Subnet IDs for the EKS cluster's VPC config"
}

# Optional tags applied to the cluster and OIDC provider resources.
# Defaults to an empty map so the module still works even if root
# doesn't explicitly pass any tags in.
variable "tags" {
  type        = map(string)
  description = "Tags applied to EKS resources"
  default     = {}
}