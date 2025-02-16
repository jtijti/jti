resource "azurerm_resource_group" "app_rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_app_service_plan" "app_service_plan" {
  name                = var.app_service_plan_name
  location            = azurerm_resource_group.app_rg.location
  resource_group_name = azurerm_resource_group.app_rg.name
  kind                = "Linux"
  reserved            = true
  sku {
    tier = "Free"
    size = "F1"
  }
}

resource "azurerm_app_service" "app_service" {
  name                = "${var.app_service_name}-${var.unique_suffix}"
  location            = azurerm_resource_group.app_rg.location
  resource_group_name = azurerm_resource_group.app_rg.name
  app_service_plan_id = azurerm_app_service_plan.app_service_plan.id

  connection_string {
    name  = "Database"
    type  = "MySQL"
    value = "mysql://${azurerm_mysql_flexible_server.app_db.administrator_login}:${azurerm_mysql_flexible_server.app_db.administrator_login}@${azurerm_mysql_flexible_server.app_db.fqdn}:3306/${azurerm_mysql_flexible_database.app_db.name}"
  }
}

resource "azurerm_mysql_flexible_server" "app_db" {
  name                   = "${var.database_name}-${var.unique_suffix}"
  resource_group_name    = azurerm_resource_group.app_rg.name
  location               = azurerm_resource_group.app_rg.location
  version                = "5.7"
  administrator_login    = var.database_username
  administrator_password = var.database_password
  sku_name               = "B_Standard_B1ms"
}

resource "azurerm_mysql_flexible_database" "app_db" {
  name                = "${var.database_name}-${var.unique_suffix}"
  resource_group_name = azurerm_resource_group.app_rg.name
  server_name         = azurerm_mysql_flexible_server.app_db.name
  charset             = "utf8"
  collation           = "utf8_general_ci"
}

resource "azurerm_virtual_network" "my_vnet" {
  name                = "vnet-${var.unique_suffix}"
  resource_group_name = azurerm_resource_group.app_rg.name
  location            = azurerm_resource_group.app_rg.location
  address_space       = ["10.10.10.0/24"]
}

resource "azurerm_subnet" "my_subnet" {
  name                 = "subnet-${var.unique_suffix}"
  resource_group_name  = azurerm_resource_group.app_rg.name
  virtual_network_name = azurerm_virtual_network.my_vnet.name
  address_prefixes     = ["10.10.10.0/25"]
}

resource "azurerm_private_endpoint" "db_private_endpoint" {
  name                = var.private_endpoint_name
  resource_group_name = azurerm_resource_group.app_rg.name
  location            = azurerm_resource_group.app_rg.location
  subnet_id           = azurerm_subnet.my_subnet.id

  private_service_connection {
    name                           = "myPrivateServiceConnection"
    private_connection_resource_id = azurerm_mysql_flexible_server.app_db.id
    is_manual_connection           = false
    subresource_names              = ["mysqlServer"]
  }

  depends_on = [azurerm_subnet.my_subnet]
}
