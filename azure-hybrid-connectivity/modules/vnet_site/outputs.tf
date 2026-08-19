output "vnet_id" {
  description = "ID of the virtual network."
  value       = azurerm_virtual_network.this.id
}

output "vnet_name" {
  description = "Name of the virtual network."
  value       = azurerm_virtual_network.this.name
}

output "gateway_id" {
  description = "ID of the VPN gateway (used to build VNet-to-VNet connections)."
  value       = azurerm_virtual_network_gateway.this.id
}

output "gateway_public_ip" {
  description = "Public IP address of the VPN gateway."
  value       = azurerm_public_ip.gateway.ip_address
}

output "vpn_asn" {
  description = "BGP ASN configured on this gateway."
  value       = var.vpn_asn
}

output "vm_private_ip" {
  description = "Private IP of the per-VNet Linux test VM."
  value       = azurerm_network_interface.vm.private_ip_address
}
