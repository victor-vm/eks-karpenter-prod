module "alb_controller" {
  source = "../../modules/alb_controller"

  cluster_name      = var.cluster_name
  aws_region        = var.aws_region
  tags              = local.common_tags
  oidc_provider_arn = module.eks.oidc_provider_arn
  oidc_issuer_url   = module.eks.oidc_issuer_url
  vpc_id            = module.vpc.vpc_id

  # Helm needs a node to land on and an admin entry first, same as Karpenter.
  depends_on = [
    aws_eks_node_group.bootstrap,
    aws_eks_access_policy_association.cluster_admin_policy,
  ]
}
