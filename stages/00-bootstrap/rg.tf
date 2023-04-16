resource "azurerm_resource_group" "hub_resource_group" {
  location = var.location
  name     = var.hub_resource_group_name
}

resource "azurerm_resource_group" "spoke_resource_group" {
  location = var.location
  name     = var.spoke_resource_group_name
}