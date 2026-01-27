resource "kubernetes_namespace" "argocd" {
  metadata {
    name = "argocd"
  }
}

data "http" "argocd_manifest" {
  url = "https://raw.githubusercontent.com/argoproj/argo-cd/refs/tags/v3.2.6/manifests/install.yaml"
}

locals {
  argocd_manifests = [
    for doc in split("\n---\n", data.http.argocd_manifest.response_body) :
    yamldecode(doc)
    if trimspace(doc) != ""
  ]
}

resource "kubernetes_manifest" "argocd" {
  for_each = {
    for i, m in local.argocd_manifests : i => m
  }

  manifest = each.value
}

resource "kubernetes_service" "argocd_server" {
  metadata {
    name      = "argocd-server"
    namespace = kubernetes_namespace.argocd.metadata[0].name
  }

  spec {
    selector = {
      "app.kubernetes.io/name" = "argocd-server"
    }
    type = "LoadBalancer"

    port {
      name        = "http"
      port        = 80
      target_port = 8080
    }
  }
}

data "kubernetes_secret" "argocd_admin" {
  metadata {
    name      = "argocd-initial-admin-secret"
    namespace = "argocd"
  }

  depends_on = [
    kubernetes_manifest.argocd
  ]
}

locals {
  argocd_admin_password = base64decode(
    data.kubernetes_secret.argocd_admin.data["password"]
  )
}