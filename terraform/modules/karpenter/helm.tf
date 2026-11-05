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
        clusterName       = var.cluster_name
        clusterEndpoint   = var.cluster_endpoint
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

  # The node bootstrap access entry must exist before Karpenter starts, or its
  # nodes cannot join the cluster. The bootstrap node group and admin access are
  # enforced by depends_on on the module call in the environment.
  depends_on = [aws_eks_access_entry.karpenter_node]
}