module "jumpbox" {
  source                  = "../../modules/jumpbox"
  location                = var.location
  resource_group          = var.hub_resource_group_name
  vnet_id                 = var.hub_vnet_id
  subnet_id               = var.hub_subnet_id
  dns_zone_name           = join(".", slice(split(".", azurerm_kubernetes_cluster.spoke_aks.private_fqdn), 1, length(split(".", azurerm_kubernetes_cluster.spoke_aks.private_fqdn))))
  dns_zone_resource_group = azurerm_kubernetes_cluster.spoke_aks.node_resource_group
}