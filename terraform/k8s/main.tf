provider "kubernetes" {
  config_path = "${path.module}/../kubeconfig.yaml"
}

provider "helm" {
  kubernetes = {
    config_path = "${path.module}/../kubeconfig.yaml"
  }
}

locals {
  workspace_root = "${path.module}/../../.."
}

data "terraform_remote_state" "infra" {
  backend = "local"
  config = {
    path = "${path.module}/../infra/terraform.tfstate"
  }
}