module "rg" {
  source   = "../child-module/azurerm_resource_group"
  rg_name  = "sandy-rg"
  location = "West Us2"
}
module "vnet" {
  depends_on          = [module.rg]
  source              = "../child-module/azurerm_virtual_network"
  vnet_name           = "sandy-vnet"
  resource_group_name = "sandy-rg"
  location            = "West Us2"
  address_space       = ["10.0.0.0/25"]
}
module "subnet" {
  depends_on           = [module.vnet]
  source               = "../child-module/azurerm_subnet"
  subnet_name          = "sandy-fe-subnet"
  virtual_network_name = "sandy-vnet"
  resource_group_name  = "sandy-rg"
  address_prefixes     = ["10.0.0.0/28"]
}
module "pip" {
  depends_on          = [module.rg]
  source              = "../child-module/azurerm_public_ip"
  pip_name            = "sandy-pip"
  resource_group_name = "sandy-rg"
  location            = "West Us2"
}
module "nic" {
  depends_on          = [module.subnet, module.pip]
  source              = "../child-module/azurerm_nic"
  nic_name            = "sandy-fe-nic"
  resource_group_name = "sandy-rg"
  location            = "West Us2"
  ip_configuration    = "sandy-fe-ip_configuration"
  subnet_name         = "sandy-fe-subnet"
  vnet_name           = "sandy-vnet"
  pip_name            = "sandy-pip"
}
module "nsg" {
  depends_on              = [module.rg]
  source                  = "../child-module/azurerm_nsg"
  nsg_name                = "sandy-nsg"
  resource_group_name     = "sandy-rg"
  location                = "West Us2"
  security_rule           = "sandy-fe-security-rule"
  destination_port_ranges = ["22", "80"]
}
module "nic_nsg" {
  depends_on          = [module.nsg, module.nic]
  source              = "../child-module/azurerm_nic_nsg"
  nic_name            = "sandy-fe-nic"
  resource_group_name = "sandy-rg"
  nsg_name            = "sandy-nsg"
}
module "kv" {
  depends_on          = [module.rg]
  source              = "../child-module/azurerm_key_vault"
  kv_name             = "sandy-kv1"
  location            = "West Us2"
  resource_group_name = "sandy-rg"
}
module "secret_username" {
  depends_on          = [module.kv]
  source              = "../child-module/azurerm_key_vault_secret"
  secret_name         = "vm-username"
  secret_value        = "fe-admin"
  kv_name             = "sandy-kv1"
  resource_group_name = "sandy-rg"
}
module "secret_password" {
  depends_on          = [module.kv]
  source              = "../child-module/azurerm_key_vault_secret"
  secret_name         = "vm-password"
  secret_value        = "Nokia@123456789"
  kv_name             = "sandy-kv1"
  resource_group_name = "sandy-rg"
}
module "vm_name" {
  depends_on           = [module.nic]
  source               = "../child-module/azurerm_vm"
  vm_name              = "sandy-fe-vm"
  resource_group_name  = "sandy-rg"
  location             = "West Us2"
  nic_name             = "sandy-fe-nic"
  kv_name              = "sandy-kv1"
  secret_username_name = "vm-username"
  secret_password_name = "vm-password"
}