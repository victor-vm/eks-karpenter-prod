module "vpc" {
  source       = "../../modules/vpc"
  cluster_name = var.cluster_name
  aws_region   = var.aws_region

  public_subnet_tags  = local.alb_public_subnet_tags
  private_subnet_tags = merge(local.karpenter_subnet_tags, local.alb_private_subnet_tags)
}
