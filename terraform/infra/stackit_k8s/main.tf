resource "stackit_ske_cluster" "example" {
  project_id = var.stackit_project_id
  region     = var.stackit_region
  name       = "example"
  node_pools = [
    {
      name               = "np-example"
      machine_type       = "t1.1"
      minimum            = "1"
      maximum            = "1"
      availability_zones = ["eu01-m"]
    }
  ]
}

resource "stackit_ske_kubeconfig" "example" {
  project_id   = var.stackit_project_id
  cluster_name = stackit_ske_cluster.example.name

  refresh        = true
  expiration     = 7200 # 2 hours
  refresh_before = 3600 # 1 hour
}

resource "local_sensitive_file" "kube_config" {
  content = stackit_ske_kubeconfig.example.kube_config
  filename = "${path.root}/../kubeconfig.yaml"
}