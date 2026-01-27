output "host" {
  value = stackit_postgresflex_user.main.host
}

output "port" {
  value = stackit_postgresflex_user.main.port
}

output "username" {
  value = stackit_postgresflex_user.main.username
}

output "password" {
  value     = stackit_postgresflex_user.main.password
  sensitive = true
}

output "uri" {
  value     = stackit_postgresflex_user.main.uri
  sensitive = true
}
