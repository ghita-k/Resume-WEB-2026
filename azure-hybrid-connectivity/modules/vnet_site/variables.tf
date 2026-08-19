variable "name" {
  description = "Logical site name, e.g. vnet1."
  type        = string
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "address_spaces" {
  description = "List of CIDR blocks for the VNet. The second entry represents the address space added to validate BGP route propagation (objective-05)."
  type        = list(string)
}

variable "subnet1_prefix" {
  type = string
}

variable "subnet2_prefix" {
  type = string
}

variable "extra_subnet_prefix" {
  description = "Subnet carved from the additional address space to validate BGP learning/propagation."
  type        = string
}

variable "gateway_subnet_prefix" {
  description = "CIDR for the mandatory GatewaySubnet."
  type        = string
}

variable "vpn_asn" {
  description = "BGP Autonomous System Number for this VNet's VPN Gateway."
  type        = number
}

variable "vpn_gateway_sku" {
  type = string
}

variable "allow_ssh" {
  description = "When true, the NSG allows inbound SSH (controlled entry point, VNet1 only)."
  type        = bool
  default     = false
}

variable "admin_username" {
  type = string
}

variable "admin_ssh_public_key" {
  type = string
}

variable "vm_size" {
  type = string
}

variable "log_analytics_workspace_id" {
  description = "Log Analytics Workspace to which the VPN gateway diagnostics are sent."
  type        = string
}

variable "diagnostics_storage_account_id" {
  description = "Storage account used for diagnostics archival."
  type        = string
}

variable "tags" {
  type    = map(string)
  default = {}
}
