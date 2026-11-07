# Persistent resources: these outlive the sandbox cluster and are never destroyed nightly.
module "ecr_repo" {
  source = "../../modules/ecr_repo"
  name   = "nginx-repo"
}

# GitHub Actions authenticates to AWS with short-lived OIDC tokens, no stored keys.
module "github_oidc" {
  source               = "../../modules/github_oidc"
  github_repository    = "victor-vm/eks-karpenter-prod"
  github_owner_id      = "36958712"
  github_repository_id = "1445606021"
  ecr_repository_arn   = module.ecr_repo.ecr_repo_arn
}
