resource "azurerm_network_security_group" "hub_nsg" {
  location            = var.location
  name                = var.hub_nsg_name
  resource_group_name = var.resource_group_name
  security_rule {
    access    = "Allow"
    direction = "Inbound"
    name      = "allow_https_from_internet"
    priority  = 100
    protocol  = "Tcp"
    source_port_range = "*"
    destination_port_range = "443"
    source_address_prefix = "*"
    destination_address_prefix = azurerm_subnet.hub_subnet.address_prefixes[0]
  }
  tags = {
    environment = "hub"
  }
}

resource "azurerm_public_ip" "firewall" {
  name                = "hub_firewall_public_ip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
  tags = {
    environment = "hub"
  }
}

resource "azurerm_firewall" "hub_firewall" {
  location            = var.location
  name                = var.hub_firewall_name
  resource_group_name = var.resource_group_name
  sku_name            = "AZFW_VNet"
  sku_tier            = "Standard"
  ip_configuration {
    name                 = "firewall_ipconfig"
    public_ip_address_id = azurerm_public_ip.firewall.id
    subnet_id = azurerm_subnet.firewall_hub_subnet.id
  }
}