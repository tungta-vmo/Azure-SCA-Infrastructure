resource "azurerm_container_registry" "acr" {
  name                = "scavmo"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Standard"

  admin_enabled = true

  tags = {
    environment = "spoke"
  }
}