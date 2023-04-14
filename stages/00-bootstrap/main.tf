resource "azurerm_resource_group" "this" {
  location = var.location
  name     = var.resource_group_name
}

resource "azurerm_storage_account" "bootstrap" {
  account_replication_type = "LRS"
  account_tier             = "Standard"
  location                 = var.location
  name                     = "bootstraptfstate2tyson"
  resource_group_name      = azurerm_resource_group.this.name
}

resource "azurerm_storage_container" "bootstrap_state" {
  name                 = "bootstraptfstate"
  storage_account_name = azurerm_storage_account.bootstrap.name
  container_access_type = "private"
}

resource "azurerm_storage_account" "network" {
  account_replication_type = "LRS"
  account_tier             = "Standard"
  location                 = var.location
  name                     = "networktfstate2tyson"
  resource_group_name      = azurerm_resource_group.this.name
}

resource "azurerm_storage_container" "network_state" {
  name                 = "networktfstate"
  storage_account_name = azurerm_storage_account.network.name
  container_access_type = "private"
}

resource "azurerm_storage_account" "init" {
  account_replication_type = "LRS"
  account_tier             = "Standard"
  location                 = var.location
  name                     = "inittfstate2tyson"
  resource_group_name      = azurerm_resource_group.this.name
}

resource "azurerm_storage_container" "init_state" {
  name                 = "inittfstate"
  storage_account_name = azurerm_storage_account.init.name
  container_access_type = "private"
}