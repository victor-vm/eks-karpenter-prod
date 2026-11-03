resource "aws_ecr_repository" "repo_name" {
  name                 = "nginx-repo"
  image_tag_mutability = "MUTABLE"
  force_delete         = true # lab only

  image_scanning_configuration {
    scan_on_push = true
  }
}

