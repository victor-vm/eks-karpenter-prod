resource "kubectl_manifest" "karpenter_node_pool" {
  yaml_body = <<-YAML
  apiVersion: karpenter.sh/v1
  kind: NodePool
  metadata:
    name: general-purpose
  spec:
    template:
      spec:
        nodeClassRef:
          group: karpenter.k8s.aws
          kind: EC2NodeClass
          name: general-purpose-x86
        requirements:
          - key: karpenter.sh/capacity-type
            operator: In
            values: ["spot", "on-demand"]

          - key: node.kubernetes.io/instance-type
            operator: In
            values: ["t3.micro", "t3.small"]
            
          - key: kubernetes.io/arch
            operator: In
            values: ["amd64"]
        expireAfter: 720h
    limits:
      cpu: "4"
    disruption:
      consolidationPolicy: WhenEmptyOrUnderutilized
      consolidateAfter: 1m
  YAML

  depends_on = [
    kubectl_manifest.karpenter_node_class
  ]
}