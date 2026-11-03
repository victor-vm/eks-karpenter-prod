terraform {
  required_version = ">= 1.5.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.0"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = "~> 1.14"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}



# # These let Terraform authenticate to the EKS cluster it just created,
# # using short-lived AWS CLI auth instead of a static kubeconfig file
# # data "aws_eks_cluster_auth" "this" {
# #   name = module.eks.cluster_name
# # }

# # provider "kubernetes" {
# #   host                   = module.eks.cluster_endpoint
# #   cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
# #   token                  = data.aws_eks_cluster_auth.this.token
# # }

# # provider "helm" {
# #   kubernetes {
# #     host                   = module.eks.cluster_endpoint
# #     cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
# #     token                  = data.aws_eks_cluster_auth.this.token
# #   }
# # }
# # provider "kubectl" {
# #   host                   = module.eks.cluster_endpoint
# #   cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
# #   token                  = data.aws_eks_cluster_auth.this.token
# #   load_config_file       = false
# # }

provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)

  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "aws"
    args        = ["eks", "get-token", "--cluster-name", module.eks.cluster_name, "--region", var.aws_region]
  }
}

provider "helm" {
  kubernetes {
    host                   = module.eks.cluster_endpoint
    cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)

    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      command     = "aws"
      args        = ["eks", "get-token", "--cluster-name", module.eks.cluster_name, "--region", var.aws_region]
    }
  }
}

provider "kubectl" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
  load_config_file       = false

  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "aws"
    args        = ["eks", "get-token", "--cluster-name", module.eks.cluster_name, "--region", var.aws_region]
  }
}
