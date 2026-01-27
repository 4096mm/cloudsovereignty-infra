terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.20"
    }
    argocd = {
      source  = "philips-labs/argocd"
      version = "~> 2.0"
    }
  }
}