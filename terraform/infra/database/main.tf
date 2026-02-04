resource "stackit_postgresflex_instance" "main" {
  project_id      = var.stackit_project_id
  name            = "main"
  acl             = ["0.0.0.0/0"] # Allow connections from any IP (for demo purposes)
  backup_schedule = "00 00 * * *"
  flavor = {
    cpu = 2
    ram = 4
  }
  replicas = 1
  storage = {
    class = "premium-perf2-stackit"
    size  = 5
  }
  version = var.postgres_version
}

resource "stackit_postgresflex_user" "manufacturer_domain" {
  project_id      = var.stackit_project_id
  instance_id = stackit_postgresflex_instance.main.instance_id
  username    = "manufacturer_user"
  roles       = ["login"]
}

resource "stackit_postgresflex_user" "order_domain" {
  project_id      = var.stackit_project_id
  instance_id = stackit_postgresflex_instance.main.instance_id
  username    = "order_user"
  roles       = ["login"]
}

resource "stackit_postgresflex_user" "supplier_domain" {
  project_id      = var.stackit_project_id
  instance_id = stackit_postgresflex_instance.main.instance_id
  username    = "supplier_user"
  roles       = ["login"]
}

resource "stackit_postgresflex_database" "manufacturer_domain" {
  instance_id = stackit_postgresflex_instance.main.instance_id
  project_id  = var.stackit_project_id
  name        = "manufacturerdomain-db"
  owner       = stackit_postgresflex_user.manufacturer_domain.username
}

resource "stackit_postgresflex_database" "order_domain" {
  instance_id = stackit_postgresflex_instance.main.instance_id
  project_id  = var.stackit_project_id
  name        = "orderdomain-db"
  owner       = stackit_postgresflex_user.order_domain.username
}

resource "stackit_postgresflex_database" "supplier_domain" {
  instance_id = stackit_postgresflex_instance.main.instance_id
  project_id  = var.stackit_project_id
  name        = "supplierdomain-db"
  owner       = stackit_postgresflex_user.supplier_domain.username
} 