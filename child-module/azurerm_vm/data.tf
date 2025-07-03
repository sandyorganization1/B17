data "azurerm_network_interface" "nic" {
    name = var.nic_name
    resource_group_name = var.resource_group_name
}
data "azurerm_key_vault" "kv" {
    name = var.kv_name
    resource_group_name = var.resource_group_name
}
data "azurerm_key_vault_secret" "secret_username" {
    name = var.secret_username_name
    key_vault_id = data.azurerm_key_vault.kv.id
}
data "azurerm_key_vault_secret" "secret_password" {
    name = var.secret_password_name
    key_vault_id = data.azurerm_key_vault.kv.id
}