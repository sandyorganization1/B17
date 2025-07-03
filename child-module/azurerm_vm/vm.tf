resource "azurerm_linux_virtual_machine" "vm" {
    name = var.vm_name
    resource_group_name = var.resource_group_name
    location = var.location
    size = "Standard_F2"
    admin_username = data.azurerm_key_vault_secret.secret_username.value
    admin_password = data.azurerm_key_vault_secret.secret_password.value
    disable_password_authentication = false
    network_interface_ids = [data.azurerm_network_interface.nic.id]
    os_disk {
        caching = "ReadWrite"
        storage_account_type = "Standard_LRS"
    }
    source_image_reference {
        publisher = "Canonical"
        offer = "0001-com-ubuntu-server-jammy"
        sku = "22_04-lts"
        version = "latest"
    }
custom_data = base64encode(<<EOF
#!/bin/bash
apt-get update
apt-get install -y nginx
systemctl enable nginx
systemctl start nginx
EOF
  )
}
