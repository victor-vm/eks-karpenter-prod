resource "kubectl_manifest" "karpenter_node_class" {
  yaml_body = <<-YAML
  apiVersion: karpenter.k8s.aws/v1
  kind: EC2NodeClass
  metadata:
    name: general-purpose-x86
  spec:
    amiFamily: AL2023
    amiSelectorTerms:
      - alias: al2023@latest
    role: ${aws_iam_role.karpenter_node_role.name}
    subnetSelectorTerms:
      - tags:
          karpenter.sh/discovery: ${var.cluster_name}
    securityGroupSelectorTerms:
      - tags:
          karpenter.sh/discovery: ${var.cluster_name}
    tags:
      karpenter.sh/discovery: ${var.cluster_name}
  YAML

  depends_on = [
    helm_release.karpenter
  ]
}