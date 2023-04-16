variable "location" {
  default = ""
}

variable "aks_name" {
  default = "sca-private-aks"
}

variable "resource_group_name" {
  default = ""
}

variable "spoke_subnet_id" {
  default = ""
}

variable "nodepool_vm_size" {
  description = "Default nodepool VM size"
  default     = "Standard_D2_v2"
}

variable "nodepool_nodes_count" {
  description = "Default nodepool nodes count"
  default     = 1
}

variable "network_docker_bridge_cidr" {
  description = "CNI Docker bridge cidr"
  default     = "172.17.0.1/16"
}

variable "network_dns_service_ip" {
  description = "CNI DNS service IP"
  default     = "10.2.0.10"
}

variable "network_service_cidr" {
  description = "CNI service cidr"
  default     = "10.2.0.0/24"
}

variable "hub_resource_group_name" {}

variable "hub_vnet_id" {}

variable "hub_subnet_id" {}

variable "azdevops_service_principal_id" {
  default = ""
}

variable "azdevops_service_principal_key" {
  default = ""
}

variable "azurerm_spn_tenantid" {
  default = ""
}

variable "azurerm_subscription_id" {
  default = ""
}

variable "azurerm_subscription_name" {
  default = ""
}

variable "public_fw_ip" {}

variable "fw_name" {}