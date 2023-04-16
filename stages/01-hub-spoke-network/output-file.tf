locals {
 tfvars = {
   location = var.location
   resource_group_name = var.spoke_resource_group_name
   hub_resource_group_name = var.hub_resource_group_name
   spoke_subnet_id = module.spoke_network.subnet_ids["aks-subnet"]
   hub_vnet_id = module.hub_network.vnet_id
   hub_subnet_id = module.hub_network.subnet_ids["jumpbox-subnet"]
   public_fw_ip = module.firewall.public_fw_Ip
   fw_name = module.firewall.fw_name
 }
}

resource "local_file" "auto_init_aks_tfvars" {
  file_permission = "0644"
  filename = "${path.module}/../02-init-aks/auto-init-aks.auto.tfvars.json"
  content = jsonencode(local.tfvars)
}
