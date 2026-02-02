output "host" {
  value = stackit_postgresflex_user.manufacturer_domain.host
}

output "port" {
  value = stackit_postgresflex_user.manufacturer_domain.port
}

output "manufacturer_dbname" {
  value = stackit_postgresflex_database.manufacturer_domain.name
}
output "manufacturer_dbuser" {
  value = stackit_postgresflex_user.manufacturer_domain.username
}
output "manufacturer_dbpassword" {
  value = stackit_postgresflex_user.manufacturer_domain.password
  sensitive = true
}

output "order_dbname" {
  value = stackit_postgresflex_database.order_domain.name
}
output "order_dbuser" {
  value = stackit_postgresflex_user.order_domain.username
}
output "order_dbpassword" {
  value = stackit_postgresflex_user.order_domain.password
  sensitive = true
}

output "supplier_dbname" {
  value = stackit_postgresflex_database.supplier_domain.name
}
output "supplier_dbuser" {
  value = stackit_postgresflex_user.supplier_domain.username
}
output "supplier_dbpassword" {
  value = stackit_postgresflex_user.supplier_domain.password
  sensitive = true
}