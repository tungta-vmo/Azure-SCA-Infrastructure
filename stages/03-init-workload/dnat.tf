resource "azurerm_firewall_nat_rule_collection" "this" {
  name                = "dnatworkload"
  azure_firewall_name = var.fw_name
  resource_group_name = var.hub_resource_group_name
  priority            = 100
  action              = "Dnat"

  rule {
    name = "toworkload"

    source_addresses = [
      "*",
    ]

    destination_ports = [
      kubernetes_service.hello-world.spec.0.port.0.port,
    ]

    destination_addresses = [
      var.public_fw_ip
    ]

    translated_port = kubernetes_service.hello-world.spec.0.port.0.port

    translated_address = kubernetes_service.hello-world.status.0.load_balancer.0.ingress.0.ip

    protocols = [
      "TCP",
    ]
  }
}