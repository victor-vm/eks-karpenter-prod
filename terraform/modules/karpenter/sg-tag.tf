# Tags the EKS cluster's auto-created security group so Karpenter's
# EC2NodeClass can discover it when launching nodes. We don't own this
# security group directly (EKS creates it), so we tag it separately
# rather than adding a tags block to a resource we don't define.
resource "aws_ec2_tag" "cluster_sg_karpenter_discovery" {
  resource_id = var.cluster_security_group_id
  key         = "karpenter.sh/discovery"
  value       = var.cluster_name
}