# Spot interruption test, Wed, Nov  4, 2026  5:30:24 PM

## Karpenter version
NAME     	NAMESPACE  	REVISION	UPDATED                              	STATUS  	CHART          	APP VERSION
karpenter	kube-system	1       	2026-11-04 16:51:48.7188729 +0530 IST	deployed	karpenter-1.8.2	1.8.2      

## Interruption queue configured in Helm
USER-SUPPLIED VALUES:
replicas: 1
serviceAccount:
  annotations:
    eks.amazonaws.com/role-arn: arn:aws:iam::986263533044:role/eks-karpenter-sandbox-karpenter-controller-role
settings:
  clusterEndpoint: https://E3E29612D8AC39CA4F19CD8D9C58D458.gr7.ap-south-1.eks.amazonaws.com
  clusterName: eks-karpenter-sandbox
  interruptionQueue: eks-karpenter-sandbox

## Karpenter log lines (message -> taint -> replacement)
{"level":"INFO","time":"2026-11-04T11:52:32.563Z","logger":"controller","message":"initiating delete from interruption message","commit":"f913f41","controller":"interruption","namespace":"","name":"","reconcileID":"52a71b61-8182-4539-ab7f-dc0f057944f6","queue":"eks-karpenter-sandbox","messageKind":"spot_interrupted","NodeClaim":{"name":"general-purpose-gkc7x"},"action":"CordonAndDrain","Node":{"name":"ip-10-0-11-145.ap-south-1.compute.internal"}}
{"level":"INFO","time":"2026-11-04T11:52:32.616Z","logger":"controller","message":"tainted node","commit":"f913f41","controller":"node.termination","controllerGroup":"","controllerKind":"Node","Node":{"name":"ip-10-0-11-145.ap-south-1.compute.internal"},"namespace":"","name":"ip-10-0-11-145.ap-south-1.compute.internal","reconcileID":"1428e397-b378-4b80-88cf-57ae170a4b17","NodeClaim":{"name":"general-purpose-gkc7x"},"taint.Key":"karpenter.sh/disrupted","taint.Value":"","taint.Effect":"NoSchedule"}
{"level":"INFO","time":"2026-11-04T11:52:36.464Z","logger":"controller","message":"launched nodeclaim","commit":"f913f41","controller":"nodeclaim.lifecycle","controllerGroup":"karpenter.sh","controllerKind":"NodeClaim","NodeClaim":{"name":"general-purpose-h2grc"},"namespace":"","name":"general-purpose-h2grc","reconcileID":"48ee0d3c-f16e-472d-8c06-6d345e3431c6","provider-id":"aws:///ap-south-1a/i-0f7adf9ea5264366f","instance-type":"t3.small","zone":"ap-south-1a","capacity-type":"spot","allocatable":{"cpu":"1930m","ephemeral-storage":"17Gi","memory":"1466648Ki","pods":"11"}}

## Nodes and capacity type
NAME                                         STATUS   ROLES    AGE     VERSION                INSTANCE-TYPE   CAPACITY-TYPE
ip-10-0-10-175.ap-south-1.compute.internal   Ready    <none>   7m43s   v1.34.12-eks-6e7947a   t3.small        spot
ip-10-0-11-216.ap-south-1.compute.internal   Ready    <none>   39m     v1.34.12-eks-6e7947a   t3.small        

## NodeClaims
NAME                    TYPE       CAPACITY   ZONE          NODE                                         READY   AGE
general-purpose-h2grc   t3.small   spot       ap-south-1a   ip-10-0-10-175.ap-south-1.compute.internal   True    8m6s

## EventBridge rules
[
    "karpenter-instance_state_change-eks-karpenter-sandbox",
    "karpenter-rebalance-eks-karpenter-sandbox",
    "karpenter-scheduled_change-eks-karpenter-sandbox",
    "karpenter-spot_interruption-eks-karpenter-sandbox"
]
