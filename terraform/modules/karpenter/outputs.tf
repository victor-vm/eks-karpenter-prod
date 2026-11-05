output "queue_name" {
  description = "SQS interruption queue name, passed to the Helm release"
  value       = aws_sqs_queue.spot_interruption_queue.name
}

output "queue_arn" {
  description = "SQS interruption queue ARN, used in the controller IAM policy"
  value       = aws_sqs_queue.spot_interruption_queue.arn
}

output "queue_url" {
  description = "SQS interruption queue URL"
  value       = aws_sqs_queue.spot_interruption_queue.url
}

output "node_role_arn" {
  value = aws_iam_role.karpenter_node_role.arn
}

output "node_role_name" {
  value = aws_iam_role.karpenter_node_role.name
}

output "controller_role_arn" {
  value = aws_iam_role.karpenter_controller_role.arn
}
