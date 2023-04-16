variable "location" {
  type = string
  default = "eastasia"
}

variable "hub_resource_group_name" {
  type = string
  description = "The hub resource group name"
  default = "hub-rg-0"
}

variable "spoke_resource_group_name" {
  type = string
  description = "The spoke resource group name"
  default = "spoke-rg-0"
}

variable "hub_vnet_name" {
  type = string
  default = "hub-vnet"
}

variable "spoke_vnet_name" {
  type = string
  default = "spoke-vnet"
}