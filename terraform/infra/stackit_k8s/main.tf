resource "stackit_ske_cluster" "cloudsovereignty_cluster" {
  project_id             = var.stackit_project_id
  region                 = var.stackit_region
  kubernetes_version_min = "1.34.3"
  name                   = "main"
  node_pools = [
    {
      name               = "default-pool"
      machine_type       = "c1a.2d"
      minimum            = "1"
      maximum            = "1"
      volume_size        = "25"
      volume_type        = "storage_premium_perf0"
      availability_zones = ["eu01-3"]
    }
  ]
}

resource "stackit_ske_kubeconfig" "cloudsovereignty_cluster_kubeconfig" {
  project_id   = var.stackit_project_id
  cluster_name = stackit_ske_cluster.cloudsovereignty_cluster.name

  refresh        = true
  expiration     = 7200 # 2 hours
  refresh_before = 3600 # 1 hour
}

resource "local_sensitive_file" "kube_config" {
  content  = stackit_ske_kubeconfig.cloudsovereignty_cluster_kubeconfig.kube_config
  filename = "${path.root}/../kubeconfig.yaml"
}
