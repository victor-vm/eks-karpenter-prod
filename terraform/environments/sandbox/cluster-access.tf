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

