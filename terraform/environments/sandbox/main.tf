module "karpenter" {
  source            = "../../modules/karpenter"
  cluster_name      = var.cluster_name
  tags              = local.common_tags
  cluster_arn       = module.eks.eks_cluster_arn
  oidc_provider_arn = module.eks.oidc_provider_arn
  oidc_issuer_url   = module.eks.oidc_issuer_url
}
