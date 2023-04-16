data "azurerm_kubernetes_service_versions" "this" {
  location = var.location
}

resource "azurerm_kubernetes_cluster" "spoke_aks" {
  location            = var.location
  name                = var.aks_name
  resource_group_name = var.resource_group_name
  kubernetes_version = data.azurerm_kubernetes_service_versions.this.latest_version
  dns_prefix = "private-aks"
  private_cluster_enabled = true

  default_node_pool {
    name    = "default"
    node_count = var.nodepool_nodes_count
    vm_size = var.nodepool_vm_size
    vnet_subnet_id = var.spoke_subnet_id
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    dns_service_ip     = var.network_dns_service_ip
    network_plugin     = "azure"
    outbound_type      = "userDefinedRouting"
    service_cidr       = var.network_service_cidr
  }
}

resource "azurerm_role_assignment" "netcontributor" {
  role_definition_name = "Network Contributor"
  scope                = var.spoke_subnet_id
  principal_id         = azurerm_kubernetes_cluster.spoke_aks.identity[0].principal_id
}
