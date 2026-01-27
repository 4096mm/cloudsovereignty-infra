provider "kubernetes" {
  config_path = "~/.kube/config"
}

provider "argocd" {
  server_addr = "https://argocd.example.com"
  auth_token  = var.argocd_token
}