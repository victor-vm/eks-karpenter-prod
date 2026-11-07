output "ecr_repo_url" {
  value = module.ecr_repo.ecr_repo_url
}

output "github_actions_role_arn" {
  value = module.github_oidc.role_arn
}
