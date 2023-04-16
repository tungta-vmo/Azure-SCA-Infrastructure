locals {
  tfvars = {
    aks_name = var.aks_name
    aks_resource_group_name = var.resource_group_name
    acr_login_server = azurerm_container_registry.acr.login_server
    public_fw_ip = var.public_fw_ip
    fw_name = var.fw_name
    hub_resource_group_name = var.hub_resource_group_name
  }
}

output "ssh_command" {
  value = "ssh -N -L 7777:localhost:8888 ${module.jumpbox.jumpbox_username}@${module.jumpbox.jumpbox_ip}"
}

resource "local_file" "jumpbox_password" {
  file_permission = "0644"
  filename = "${path.module}/jumpbox_password.txt"
  content = module.jumpbox.jumpbox_password
}

resource "local_file" "init_workload_tfvars" {
  file_permission = "0644"
  filename = "${path.module}/../03-init-workload/03-init-workload.auto.tfvars.json"
  content = jsonencode(local.tfvars)
}