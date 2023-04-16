module "hub_network" {
  source              = "../../modules/vnet"
  resource_group_name = var.hub_resource_group_name
  location            = var.location
  vnet_name           = var.hub_vnet_name
  address_space       = ["10.0.0.0/22"]
  subnets             = [
    {
      name : "AzureFirewallSubnet"
      address_prefixes : ["10.0.0.0/24"]
    },
    {
      name : "jumpbox-subnet"
      address_prefixes : ["10.0.1.0/24"]
    }
  ]
}

module "spoke_network" {
  source              = "../../modules/vnet"
  resource_group_name = var.spoke_resource_group_name
  location            = var.location
  vnet_name           = var.spoke_vnet_name
  address_space       = ["10.1.0.0/22"]
  subnets             = [
    {
      name : "aks-subnet"
      address_prefixes : ["10.1.0.0/24"]
    }
  ]
}

module "vnet_peering" {
  source              = "../../modules/vnet_peering"
  vnet_1_name         = var.hub_vnet_name
  vnet_1_id           = module.hub_network.vnet_id
  vnet_1_rg           = var.hub_resource_group_name
  vnet_2_name         = var.spoke_vnet_name
  vnet_2_id           = module.spoke_network.vnet_id
  vnet_2_rg           = var.spoke_resource_group_name
  peering_name_1_to_2 = "Hub0-To-Spoke0"
  peering_name_2_to_1 = "Spoke0-To-Hub0"
}

module "firewall" {
  source                  = "../../modules/firewall"
  resource_group          = var.hub_resource_group_name
  location                = var.location
  firewall_public_ip_name = "azureFirewalls-ip"
  fw_name                 = "hub-firewall"
  subnet_id               = module.hub_network.subnet_ids["AzureFirewallSubnet"]
}

module "routetable" {
  source             = "../../modules/route_table"
  resource_group     = var.hub_resource_group_name
  location           = var.location
  rt_name            = "hub-firewall_fw_rt"
  r_name             = "hub-firewall_fw_r"
  firewal_private_ip = module.firewall.fw_private_ip
  firewall_public_ip = module.firewall.public_fw_Ip
  subnet_id          = module.spoke_network.subnet_ids["aks-subnet"]
}