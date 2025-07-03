resource "azurerm_network_security_group" "nsg" {
    name = var.nsg_name
    resource_group_name = var.resource_group_name
    location = var.location
    security_rule {
        name = var.security_rule
        direction = "Inbound"
        access = "Allow"
        protocol ="Tcp"
        priority = 100
        source_port_range = "*"
        destination_port_ranges = var.destination_port_ranges
        source_address_prefix = "*"
        destination_address_prefix = "*"
    }
}