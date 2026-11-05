resource "helm_release" "karpenter" {
  # Deploy Karpenter directly into the standard Kubernetes system namespace
  namespace        = "kube-system"
  create_namespace = false

  # Helm chart metadata (pulling the official OCI artifact from AWS ECR Public)
  name       = "karpenter"
  repository = "oci://public.ecr.aws/karpenter"
  chart      = "karpenter"
  version    = "1.8.2"




  # Dynamically generate values.yaml configuration for the Karpenter Helm chart
  values = [
    yamlencode({
      # Run a single replica of the Karpenter controller for standard operations
      replicas = 1

      # Core settings required for Karpenter to discover and manage the EKS cluster
      settings = {
        clusterName       = module.eks.cluster_name
        clusterEndpoint   = module.eks.cluster_endpoint
        interruptionQueue = aws_sqs_queue.spot_interruption_queue.name # Populated once the SQS interruption queue resource is set up
      }

      # IAM Roles for Service Accounts (IRSA): 
      # Binds the Kubernetes service account to the AWS IAM controller role 
      # so Karpenter has permissions to call the EC2 and EKS APIs.
      serviceAccount = {
        annotations = {
          "eks.amazonaws.com/role-arn" = aws_iam_role.karpenter_controller_role.arn
        }
      }
    })
  ]

  # CRITICAL DEPENDENCY ORDERING (Prevents Race Conditions):
  # 1. aws_eks_node_group.bootstrap: Ensures initial control-plane compute is up.
  # 2. cluster_admin_policy: Guarantees your execution identity has admin access 
  #    via EKS Access Entries before the Helm provider tries to connect.
  # 3. karpenter_node: Ensures the EC2 node trust entry is registered.
  depends_on = [
    aws_eks_node_group.bootstrap,
    aws_eks_access_policy_association.cluster_admin_policy,
    aws_eks_access_entry.karpenter_node
  ]
}