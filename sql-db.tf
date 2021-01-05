provider "azurerm" {
  version = "~>2.0"
  features {}
}

terraform {
    backend "azurerm" {}
}

resource "azurerm_resource_group" "example" {
  name     = "aks-test"
  location = "East US"
}

resource "azurerm_storage_account" "example" {
  name                     = "aksrgtest1"
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_sql_server" "example" {
  name                         = "aksrg"
  resource_group_name          = azurerm_resource_group.example.name
  location                     = azurerm_resource_group.example.location
  version                      = "12.0"
  administrator_login          = "admin1"
  administrator_login_password = "S@@Spaas"
}

resource "azurerm_mssql_database" "test" {
  name           = "sqlrgdb"
  server_id      = azurerm_sql_server.example.id
  collation      = "SQL_Latin1_General_CP1_CI_AS"
  license_type   = "LicenseIncluded"
  max_size_gb    = 250
  read_scale     = true
  sku_name       = "S1"
  zone_redundant = false

  extended_auditing_policy {
    storage_endpoint                        = azurerm_storage_account.example.primary_blob_endpoint
    storage_account_access_key              = azurerm_storage_account.example.primary_access_key
    storage_account_access_key_is_secondary = true
    retention_in_days                       = 0
  }


  tags = {
    foo = "bar"
  }

}
