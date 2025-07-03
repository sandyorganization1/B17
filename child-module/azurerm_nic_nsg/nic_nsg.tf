resource "azurerm_network_interface_security_group_association" "nic-nsg" {
    network_interface_id = data.azurerm_network_interface.nic.id
    network_security_group_id = data.azurerm_network_security_group.nsg.id
}

data "azurerm_network_interface" "nic" {
    name = var.nic_name
    resource_group_name = var.resource_group_name
}

data "azurerm_network_security_group" "nsg" {
    name = var.nsg_name
    resource_group_name = var.resource_group_name
}