resource "stackit_postgresflex_instance" "main" {
  project_id      = var.stackit_project_id
  name            = "main"
  acl             = ["0.0.0.0/0"]
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

resource "stackit_postgresflex_user" "main" {
  project_id      = var.stackit_project_id
  instance_id = stackit_postgresflex_instance.main.instance_id
  username    = "mainuser"
  roles       = ["login", "createdb"]
}