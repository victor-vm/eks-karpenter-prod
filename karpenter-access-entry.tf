# ==========================================
# 1. DYNAMIC CLUSTER ADMIN ACCESS ENTRY
# ==========================================
# Dynamically fetches the current runner's identity (engineer or CI/CD pipeline role)
data "aws_caller_identity" "current" {}
data "aws_iam_session_context" "current" {
  arn = data.aws_caller_identity.current.arn
}

# Grants the current execution identity admin access to EKS natively via Access Entries
resource "aws_eks_access_entry" "cluster_admin" {
  cluster_name  = module.eks.cluster_name
  principal_arn = data.aws_iam_session_context.current.issuer_arn
  type          = "STANDARD"
}

# Associates the AWS managed AmazonEKSClusterAdminPolicy to your identity
resource "aws_eks_access_policy_association" "cluster_admin_policy" {
  cluster_name  = module.eks.cluster_name
  policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
  principal_arn = aws_eks_access_entry.cluster_admin.principal_arn

  access_scope {
    type = "cluster"
  }
}

# ==========================================
# 2. KARPENTER NODE BOOTSTRAP ACCESS ENTRY
# ==========================================
# Managed Node Groups auto-register their IAM role with the cluster when
# created. Karpenter bypasses that entirely — it calls the EC2 API directly
# to launch nodes, so nothing ever tells the cluster to trust
# karpenter_node_role. Without this, Karpenter's nodes launch successfully
# in AWS but get rejected when the kubelet tries to register with the API
# server, and never become real Kubernetes Node objects.
resource "aws_eks_access_entry" "karpenter_node" {
  cluster_name  = module.eks.cluster_name
  principal_arn = aws_iam_role.karpenter_node_role.arn

  # EC2_LINUX is a special access-entry type built for exactly this case —
  # it grants node bootstrap permissions automatically, no separate policy
  # association needed (unlike a human/admin access entry).
  type = "EC2_LINUX"
}