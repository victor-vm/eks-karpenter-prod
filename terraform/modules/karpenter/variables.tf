variable "cluster_name" {
  description = "EKS cluster name, also used as the SQS queue name"
  type        = string
}

variable "tags" {
  description = "Common tags applied to resources"
  type        = map(string)
  default     = {}
}
