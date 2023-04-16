locals {
  backend_template = "${path.module}/template/backend.tf.tpl"

  backends = {
    "auto-00-bootstrap" = templatefile(local.backend_template, {
      resource_group_name = azurerm_resource_group.this.name
      storage_account_name = azurerm_storage_account.bootstrap.name
      container_name = azurerm_storage_container.bootstrap_state.name
      key = "bootstrap.terraform.tfstate"
    })
    "auto-01-hub-spoke-network" = templatefile(local.backend_template, {
      resource_group_name = azurerm_resource_group.this.name
      storage_account_name = azurerm_storage_account.network.name
      container_name = azurerm_storage_container.network_state.name
      key = "network.terraform.tfstate"
    } )
    "auto-02-init-aks" = templatefile(local.backend_template, {
      resource_group_name = azurerm_resource_group.this.name
      storage_account_name = azurerm_storage_account.init.name
      container_name = azurerm_storage_container.init_state.name
      key = "init.terraform.tfstate"
    } )
    "auto-03-init-workload" = templatefile(local.backend_template, {
      resource_group_name = azurerm_resource_group.this.name
      storage_account_name = azurerm_storage_account.init_workload.name
      container_name = azurerm_storage_container.init_workload.name
      key = "init.workload.terraform.tfstate"
    } )
  }

  tfvars = {
    location = var.location
    hub_resource_group_name = azurerm_resource_group.hub_resource_group.name
    spoke_resource_group_name = azurerm_resource_group.spoke_resource_group.name
  }
}

resource "local_file" "all_backend_state" {
  for_each = local.backends
  file_permission = "0644"
  filename = "${path.module}/../data_file/backends/${each.key}-${var.resource_group_name}-backend.tf"
  content         = try(each.value, null)
}

resource "local_file" "bootstrap_backend_state" {
  file_permission = "0644"
  filename = "${path.module}/00-bootstrap-${var.resource_group_name}-backend.tf"
  content         = local.backends.auto-00-bootstrap
}

resource "local_file" "network_backend_state" {
  file_permission = "0644"
  filename = "${path.module}/../01-hub-spoke-network/01-hub-spoke-network-${var.resource_group_name}-backend.tf"
  content         = local.backends.auto-01-hub-spoke-network
}

resource "local_file" "init_backend_state" {
  file_permission = "0644"
  filename = "${path.module}/../02-init-aks/02-init-aks-${var.resource_group_name}-backend.tf"
  content         = local.backends.auto-02-init-aks
}

resource "local_file" "init_workload_backend_state" {
  file_permission = "0644"
  filename = "${path.module}/../03-init-workload/03-init-workload-${var.resource_group_name}-backend.tf"
  content         = local.backends.auto-03-init-workload
}

resource "local_file" "hub_and_spoke_network" {
  file_permission = "0644"
  filename = "${path.module}/../01-hub-spoke-network/01-hub-spoke-network.auto.tfvars.json"
  content = jsonencode(local.tfvars)
}