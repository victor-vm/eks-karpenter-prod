locals {
  common_tags = {
    Environment = "sandbox"
    ManagedBy   = "terraform"
    Cluster     = var.cluster_name
  }

  # Dynamically assign availability zones based on your chosen region
  azs = ["${var.aws_region}a", "${var.aws_region}b"]
}