# The cluster's name, exposed so root (or anything calling this module)
# can reference it without hardcoding var.cluster_name again elsewhere.
output "cluster_name" {
  value = aws_eks_cluster.main.name
}

# The API server endpoint URL. Needed later for kubectl/helm/kubernetes
# provider configuration to actually talk to this cluster.
output "cluster_endpoint" {
  value = aws_eks_cluster.main.endpoint
}

# The cluster's certificate authority data, base64-encoded. Needed
# alongside the endpoint above so kubectl/helm can establish a trusted
# TLS connection to the API server.
output "cluster_certificate_authority_data" {
  value = aws_eks_cluster.main.certificate_authority[0].data
}

# The ARN of the OIDC provider we registered with IAM. This is the
# missing piece iam-karpenter.tf has been waiting for — once this
# module is called from root, iam-karpenter.tf will reference this
# as module.eks.oidc_provider_arn instead of the deleted variable.
output "oidc_provider_arn" {
  value = aws_iam_openid_connect_provider.eks.arn
}

# The OIDC issuer URL itself. iam-karpenter.tf's trust policy condition
# needs this value (with "https://" stripped) to match tokens correctly.
output "oidc_issuer_url" {
  value = aws_iam_openid_connect_provider.eks.url
}


# The EKS cluster's auto-created security group ID. Karpenter's
# EC2NodeClass needs this tagged with karpenter.sh/discovery so it
# knows which security group to attach to nodes it launches.
output "cluster_security_group_id" {
  value = aws_eks_cluster.main.vpc_config[0].cluster_security_group_id
}

output "eks_cluster_arn" {
  description = "The ARN of the EKS cluster"
  value       = aws_eks_cluster.main.arn
}