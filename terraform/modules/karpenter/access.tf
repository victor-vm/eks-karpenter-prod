# Karpenter launches nodes through the EC2 API, so nothing registers its node
# role with the cluster. Without this entry the nodes launch in AWS but the
# kubelet is rejected and they never become Kubernetes Nodes.
# EC2_LINUX grants node bootstrap permissions automatically.
resource "aws_eks_access_entry" "karpenter_node" {
  cluster_name  = var.cluster_name
  principal_arn = aws_iam_role.karpenter_node_role.arn
  type          = "EC2_LINUX"
}
