resource "azurerm_network_interface" "nic" {
    name = var.nic_name
    resource_group_name = var.resource_group_name
    location = var.location
    ip_configuration {
        name = var.ip_configuration
        subnet_id = data.azurerm_subnet.subnet.id
        public_ip_address_id = data.azurerm_public_ip.pip.id
        private_ip_address_allocation= "Dynamic"
    }
}

data "azurerm_subnet" "subnet" {
    name = var.subnet_name
    resource_group_name = var.resource_group_name
    virtual_network_name = var.vnet_name
}

data "azurerm_public_ip" "pip" {
    name = var.pip_name
    resource_group_name = var.resource_group_name  
}