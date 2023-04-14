variable "location" {
  type = string
  default = "eastasia"
}

variable "resource_group_name" {
  type = string
  default = "sca"
}

variable "hub_vnet_name" {
  type = string
  default = "hub-vnet"
}

variable "spoke_vnet_name" {
  type = string
  default = "spoke-vnet"
}

variable "hub_subnet_name" {
  type = string
  default = "hub-subnet"
}

variable "spoke_subnet_name" {
  type = string
  default = "spoke-subnet"
}

variable "hub_nsg_name" {
  type = string
  default = "hub-nsg"
}

variable "hub_firewall_name" {
  type = string
  default = "hub-firewall"
}
