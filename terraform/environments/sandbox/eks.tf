# Calls the EKS module, passing in real values from this project
module "eks" {
  source = "../../modules/eks"

  cluster_name     = var.cluster_name
  cluster_role_arn = aws_iam_role.eks_cluster.arn # from iam-cluster.tf
  cluster_version  = "1.34"

  subnet_ids = concat(
    module.vpc.private_subnet_ids,
    module.vpc.public_subnet_ids
  )

  tags = local.common_tags
}


