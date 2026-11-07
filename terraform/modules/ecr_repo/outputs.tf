output "ecr_repo_url" {
  value = aws_ecr_repository.repo_name.repository_url
}
output "ecr_repo_arn" {
  value = aws_ecr_repository.repo_name.arn
}
