provider "stackit" {
    service_account_key_path = "../sa-key.json"
}

module "database" {
    source = "./database"
    stackit_project_id = var.stackit_project_id
    stackit_region = var.stackit_region
}

module "k8s" {
    source = "./stackit_k8s"
    stackit_project_id = var.stackit_project_id
    stackit_region = var.stackit_region
}

/*
ToDo: Add DNS zone resource back when needed for tls certificates
resource "stackit_dns_zone" "example" {
  project_id    = var.stackit_project_id
  name          = "Example zone"
  dns_name      = "cloudsovereignty-showcase.stackit.gg"
  contact_email = "ToDo"
  type          = "primary"
  default_ttl   = 1230
}*/