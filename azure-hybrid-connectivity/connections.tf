# Chained VNet-to-VNet topology (BGP enabled on every connection):
#
#   VNet1 <== BGP ==> VNet2 <== BGP ==> VNet3
#
# There is intentionally NO direct VNet1 <-> VNet3 connection. Reachability
# between VNet1 and VNet3 must be learned dynamically via BGP through VNet2.
#
# Each tunnel needs a connection object on both ends, so four connections total.

resource "azurerm_virtual_network_gateway_connection" "vnet1_to_vnet2" {
  name                = "cn-vnet1-to-vnet2"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name

  type                            = "Vnet2Vnet"
  virtual_network_gateway_id      = module.vnet1.gateway_id
  peer_virtual_network_gateway_id = module.vnet2.gateway_id

  bgp_enabled = true
  shared_key  = var.vpn_shared_key
  tags        = var.tags
}

resource "azurerm_virtual_network_gateway_connection" "vnet2_to_vnet1" {
  name                = "cn-vnet2-to-vnet1"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name

  type                            = "Vnet2Vnet"
  virtual_network_gateway_id      = module.vnet2.gateway_id
  peer_virtual_network_gateway_id = module.vnet1.gateway_id

  bgp_enabled = true
  shared_key  = var.vpn_shared_key
  tags        = var.tags
}

resource "azurerm_virtual_network_gateway_connection" "vnet2_to_vnet3" {
  name                = "cn-vnet2-to-vnet3"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name

  type                            = "Vnet2Vnet"
  virtual_network_gateway_id      = module.vnet2.gateway_id
  peer_virtual_network_gateway_id = module.vnet3.gateway_id

  bgp_enabled = true
  shared_key  = var.vpn_shared_key
  tags        = var.tags
}

resource "azurerm_virtual_network_gateway_connection" "vnet3_to_vnet2" {
  name                = "cn-vnet3-to-vnet2"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name

  type                            = "Vnet2Vnet"
  virtual_network_gateway_id      = module.vnet3.gateway_id
  peer_virtual_network_gateway_id = module.vnet2.gateway_id

  bgp_enabled = true
  shared_key  = var.vpn_shared_key
  tags        = var.tags
}
