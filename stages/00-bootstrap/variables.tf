variable "location" {
  type = string
  description = "The location of resource on AZ"
  default = "eastasia"
}

variable "resource_group_name" {
  type = string
  description = "The Resource Group"
  default = "sca"
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