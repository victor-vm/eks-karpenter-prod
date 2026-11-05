module "karpenter" {
  source                    = "../../modules/karpenter"
  cluster_name              = var.cluster_name
  tags                      = local.common_tags
  cluster_arn               = module.eks.eks_cluster_arn
  oidc_provider_arn         = module.eks.oidc_provider_arn
  oidc_issuer_url           = module.eks.oidc_issuer_url
  cluster_endpoint          = module.eks.cluster_endpoint
  cluster_security_group_id = module.eks.cluster_security_group_id

  # Helm needs a node to land on and an admin entry before Karpenter installs.
  # These live outside the module, so the dependency goes here on the call.
  depends_on = [
    aws_eks_node_group.bootstrap,
    aws_eks_access_policy_association.cluster_admin_policy,
  ]
}
