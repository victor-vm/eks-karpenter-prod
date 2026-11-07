locals {
  owner = split("/", var.github_repository)[0]
  repo  = split("/", var.github_repository)[1]
}
