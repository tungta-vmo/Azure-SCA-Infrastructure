resource "azurerm_virtual_network" "spoke_net" {
  address_space       = ["10.1.0.0/16"]
  location            = var.location
  name                = var.spoke_vnet_name
  resource_group_name = var.resource_group_name
  tags = {
    environemnt = "spoke"
  }
}

resource "azurerm_subnet" "spoke_subnet" {
  address_prefixes     = ["10.1.0.0/24"]
  name                 = var.spoke_subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.spoke_net.name
}