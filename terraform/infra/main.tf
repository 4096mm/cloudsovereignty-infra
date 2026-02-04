provider "stackit" {
    service_account_key_path = "${path.module}/../sa-key.json"
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