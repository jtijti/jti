output "app_service_url" {
  value = azurerm_app_service.app_service.default_site_hostname
}

output "admin_login" {
  value = azurerm_mysql_flexible_server.app_db.administrator_login
}

output "admin_password" {
  sensitive = true
  value     = azurerm_mysql_flexible_server.app_db.administrator_password
}

output "database_name" {
  value = azurerm_mysql_flexible_database.app_db.name
}

output "mysql_connection_string" {
  sensitive = true
  value = "mysql://${azurerm_mysql_flexible_server.app_db.administrator_login}:${azurerm_mysql_flexible_server.app_db.administrator_password}@${azurerm_mysql_flexible_server.app_db.fqdn}:3306/${azurerm_mysql_flexible_database.app_db.name}"
}
