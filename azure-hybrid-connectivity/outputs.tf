output "resource_group_name" {
  description = "Resource group holding the lab."
  value       = azurerm_resource_group.this.name
}

output "log_analytics_workspace_id" {
  description = "Centralized Log Analytics Workspace ID."
  value       = azurerm_log_analytics_workspace.this.id
}

output "diagnostics_storage_account" {
  description = "Diagnostics storage account name."
  value       = azurerm_storage_account.diagnostics.name
}

output "sites" {
  description = "Per-VNet summary (gateway public IP, BGP ASN, test VM private IP)."
  value = {
    vnet1 = {
      vnet_name         = module.vnet1.vnet_name
      gateway_public_ip = module.vnet1.gateway_public_ip
      vpn_asn           = module.vnet1.vpn_asn
      vm_private_ip     = module.vnet1.vm_private_ip
    }
    vnet2 = {
      vnet_name         = module.vnet2.vnet_name
      gateway_public_ip = module.vnet2.gateway_public_ip
      vpn_asn           = module.vnet2.vpn_asn
      vm_private_ip     = module.vnet2.vm_private_ip
    }
    vnet3 = {
      vnet_name         = module.vnet3.vnet_name
      gateway_public_ip = module.vnet3.gateway_public_ip
      vpn_asn           = module.vnet3.vpn_asn
      vm_private_ip     = module.vnet3.vm_private_ip
    }
  }
}
