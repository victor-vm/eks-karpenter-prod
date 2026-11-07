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


output "cluster_name" {
  description = "The name of the EKS cluster"
  value       = module.eks.cluster_name
}

output "interruption_queue_url" {
  value = module.karpenter.queue_url
}

output "interruption_queue_arn" {
  value = module.karpenter.queue_arn
}