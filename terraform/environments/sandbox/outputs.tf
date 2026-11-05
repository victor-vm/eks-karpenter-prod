output "vpc_id" {
  description = "The ID of the main VPC"
  value       = module.vpc.vpc_id
}

output "public_subnet_ids" {
  description = "List of public subnet IDs"
  value       = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  description = "List of private subnet IDs"
  value       = module.vpc.private_subnet_ids
}

output "ecr_repo_url" {
  value = module.ecr_repo.ecr_repo_url
}

output "cluster_name" {
  description = "The name of the EKS cluster"
  value       = module.eks.cluster_name
}

output "interruption_queue_url" {
  value = aws_sqs_queue.spot_interruption_queue.url
}

output "interruption_queue_arn" {
  value = aws_sqs_queue.spot_interruption_queue.arn
}