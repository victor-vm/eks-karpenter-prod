#In EKS terminology, this creates the managed Kubernetes control plan
resource "aws_eks_cluster" "main" {
  name     = var.cluster_name
  role_arn = var.cluster_role_arn
  version  = var.cluster_version

  # Enables EKS Access Entries (the modern way to authorize IAM roles to
  # join the cluster), while keeping the older aws-auth ConfigMap working
  # too, for compatibility with anything still using it.
  access_config {
    authentication_mode = "API_AND_CONFIG_MAP"
  }
  vpc_config {
    subnet_ids              = var.subnet_ids
    endpoint_public_access  = true
    endpoint_private_access = true
  }

  tags = var.tags
}

#Retrieving the Cluster's OIDC Issuer Certificate

data "tls_certificate" "eks_oidc" {
  url = aws_eks_cluster.main.identity[0].oidc[0].issuer
}

# Registering EKS as a Trusted Identity Provider in IAM

resource "aws_iam_openid_connect_provider" "eks" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.eks_oidc.certificates[0].sha1_fingerprint]
  url             = aws_eks_cluster.main.identity[0].oidc[0].issuer

  tags = var.tags
}



 