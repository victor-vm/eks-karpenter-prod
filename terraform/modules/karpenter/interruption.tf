# SQS Queue
resource "aws_sqs_queue" "spot_interruption_queue" {
  name = var.cluster_name

  message_retention_seconds = 300 # 5 minutes retention for messages, as Karpenter will process them quickly
  sqs_managed_sse_enabled   = true

  tags = var.tags
}