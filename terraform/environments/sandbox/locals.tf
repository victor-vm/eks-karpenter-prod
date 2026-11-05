locals {
  common_tags = {
    Environment = "sandbox"
    ManagedBy   = "terraform"
    Cluster     = var.cluster_name
  }

  # Dynamically assign availability zones based on your chosen region
  azs = ["${var.aws_region}a", "${var.aws_region}b"]
}
# Tags are grouped by the component that needs them, then merged per subnet type.
locals {
  karpenter_subnet_tags = {
    "karpenter.sh/discovery" = var.cluster_name
  }

  alb_public_subnet_tags = {
    "kubernetes.io/role/elb" = "1"
  }

  alb_private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = "1"
  }
}
