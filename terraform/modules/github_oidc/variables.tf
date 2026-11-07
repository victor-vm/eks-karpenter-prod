variable "github_repository" {
  type        = string
  description = "GitHub repository allowed to assume the role, as owner/name"
}

variable "github_branch" {
  type        = string
  description = "Branch allowed to assume the role"
  default     = "main"
}

variable "ecr_repository_arn" {
  type        = string
  description = "ARN of the ECR repository the role may push to"
}

variable "role_name" {
  type        = string
  description = "Name of the IAM role assumed by GitHub Actions"
  default     = "github-actions-ecr-push"
}

variable "github_owner_id" {
  type        = string
  description = "Numeric GitHub owner ID, part of the immutable OIDC subject"
}

variable "github_repository_id" {
  type        = string
  description = "Numeric GitHub repository ID, part of the immutable OIDC subject"
}
