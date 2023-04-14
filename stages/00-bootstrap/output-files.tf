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
