# Three VNet "sites", each with a consistent subnet layout (subnet1, subnet2,
# GatewaySubnet), an NSG, a VPN Gateway with BGP, and a Linux test VM.
#
# The second address space of each VNet + its "subnet-bgp-validation" subnet
# exist to validate BGP route learning and propagation (objective-05).

module "vnet1" {
  source = "./modules/vnet_site"

  name                = "vnet1"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name

  address_spaces        = ["10.1.0.0/16", "10.11.0.0/16"]
  subnet1_prefix        = "10.1.1.0/24"
  subnet2_prefix        = "10.1.2.0/24"
  extra_subnet_prefix   = "10.11.1.0/24"
  gateway_subnet_prefix = "10.1.255.0/27"
  vpn_asn               = 65001

  # VNet1 is the controlled entry point: SSH is only allowed here.
  allow_ssh = true

  vpn_gateway_sku      = var.vpn_gateway_sku
  admin_username       = var.admin_username
  admin_ssh_public_key = var.admin_ssh_public_key
  vm_size              = var.vm_size

  log_analytics_workspace_id     = azurerm_log_analytics_workspace.this.id
  diagnostics_storage_account_id = azurerm_storage_account.diagnostics.id

  tags = var.tags
}

module "vnet2" {
  source = "./modules/vnet_site"

  name                = "vnet2"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name

  address_spaces        = ["10.2.0.0/16", "10.12.0.0/16"]
  subnet1_prefix        = "10.2.1.0/24"
  subnet2_prefix        = "10.2.2.0/24"
  extra_subnet_prefix   = "10.12.1.0/24"
  gateway_subnet_prefix = "10.2.255.0/27"
  vpn_asn               = 65002

  allow_ssh = false

  vpn_gateway_sku      = var.vpn_gateway_sku
  admin_username       = var.admin_username
  admin_ssh_public_key = var.admin_ssh_public_key
  vm_size              = var.vm_size

  log_analytics_workspace_id     = azurerm_log_analytics_workspace.this.id
  diagnostics_storage_account_id = azurerm_storage_account.diagnostics.id

  tags = var.tags
}

module "vnet3" {
  source = "./modules/vnet_site"

  name                = "vnet3"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name

  address_spaces        = ["10.3.0.0/16", "10.13.0.0/16"]
  subnet1_prefix        = "10.3.1.0/24"
  subnet2_prefix        = "10.3.2.0/24"
  extra_subnet_prefix   = "10.13.1.0/24"
  gateway_subnet_prefix = "10.3.255.0/27"
  vpn_asn               = 65003

  allow_ssh = false

  vpn_gateway_sku      = var.vpn_gateway_sku
  admin_username       = var.admin_username
  admin_ssh_public_key = var.admin_ssh_public_key
  vm_size              = var.vm_size

  log_analytics_workspace_id     = azurerm_log_analytics_workspace.this.id
  diagnostics_storage_account_id = azurerm_storage_account.diagnostics.id

  tags = var.tags
}
