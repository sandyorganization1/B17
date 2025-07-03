resource "azurerm_key_vault_secret" "secret" {
  name         = var.secret_name
  value        = var.secret_value
  key_vault_id = data.azurerm_key_vault.kv.id
}

data "azurerm_key_vault" "kv" {
    name = var.kv_name
    resource_group_name = var.resource_group_name
}
resource "azurerm_key_vault_access_policy" "terraform_user" {
  key_vault_id = data.azurerm_key_vault.kv.id

  tenant_id = data.azurerm_client_config.current.tenant_id
  object_id = data.azurerm_client_config.current.object_id

  secret_permissions = [
    "Set", "Get", "List"
  ]
}

data "azurerm_client_config" "current" {}
