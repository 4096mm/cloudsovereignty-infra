output "dbhost" {
  value = module.database.host
}
output "dbport" {
  value = module.database.port
}

output "manufacturer_dbname" {
  value = module.database.manufacturer_dbname
}
output "manufacturer_dbuser" {
  value = module.database.manufacturer_dbuser
}
output "manufacturer_dbpassword" {
  value = module.database.manufacturer_dbpassword
  sensitive = true
}

output "order_dbname" {
  value = module.database.order_dbname
}
output "order_dbuser" {
  value = module.database.order_dbuser
}
output "order_dbpassword" {
  value = module.database.order_dbpassword
  sensitive = true
}

output "supplier_dbname" {
  value = module.database.supplier_dbname
}
output "supplier_dbuser" {
  value = module.database.supplier_dbuser
}
output "supplier_dbpassword" {
  value = module.database.supplier_dbpassword
  sensitive = true
}