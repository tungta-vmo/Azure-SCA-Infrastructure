resource "azurerm_virtual_network" "hub_vnet" {
  name = var.hub_vnet_name
  location = var.location
  resource_group_name = var.resource_group_name
  address_space = ["10.0.0.0/16"]
  tags = {
    environment = "hub"
  }
}

resource "azurerm_subnet" "hub_subnet" {
  name = var.hub_subnet_name
  resource_group_name = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.hub_vnet.name
  address_prefixes = ["10.0.0.0/24"]
}

resource "azurerm_subnet" "firewall_hub_subnet" {
  name = "AzureFirewallSubnet"
  resource_group_name = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.hub_vnet.name
  address_prefixes = ["10.0.1.0/24"]
}

