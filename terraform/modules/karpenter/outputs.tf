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
