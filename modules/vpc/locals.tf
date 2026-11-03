locals {
  common_tags = {
    Environment = "sandbox"
    ManagedBy   = "terraform"
    Cluster     = var.cluster_name
  }

  azs = ["${var.aws_region}a", "${var.aws_region}b"]
}
