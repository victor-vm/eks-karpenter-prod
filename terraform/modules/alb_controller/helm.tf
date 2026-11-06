resource "helm_release" "alb_controller" {
  name       = "aws-load-balancer-controller"
  namespace  = local.namespace
  repository = "https://aws.github.io/eks-charts"
  chart      = "aws-load-balancer-controller"
  version    = "1.14.0" # controller v2.14.1

  values = [
    yamlencode({
      clusterName  = var.cluster_name
      region       = var.aws_region
      vpcId        = var.vpc_id
      replicaCount = 1

      serviceAccount = {
        create = true
        name   = local.service_account_name
        annotations = {
          "eks.amazonaws.com/role-arn" = aws_iam_role.alb_controller.arn
        }
      }
    })
  ]

  # The pod must not start before its permissions exist.
  depends_on = [aws_iam_role_policy_attachment.alb_controller]
}
