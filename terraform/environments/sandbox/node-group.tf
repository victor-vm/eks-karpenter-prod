# The bootstrap managed node group — small, fixed set of nodes that
# keep the cluster alive and run the Karpenter controller
resource "aws_eks_node_group" "bootstrap" {
  cluster_name    = module.eks.cluster_name
  node_group_name = "${var.cluster_name}-bootstrap"
  node_role_arn   = aws_iam_role.eks_nodes.arn # from iam-nodes.tf
  subnet_ids      = module.vpc.private_subnet_ids

  ami_type = "AL2023_x86_64_STANDARD" # NEW — matches EKS 1.34's required AMI type


  scaling_config {
    min_size     = 1
    max_size     = 2
    desired_size = 1
  }

  instance_types = var.bootstrap_instance_types

  tags = local.common_tags
}