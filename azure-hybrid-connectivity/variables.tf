variable "subscription_id" {
  description = "Azure subscription ID. Prefer the ARM_SUBSCRIPTION_ID env var; leave null to use the az CLI context."
  type        = string
  default     = null
}

variable "location" {
  description = "Azure region for all resources."
  type        = string
  default     = "westeurope"
}

variable "resource_group_name" {
  description = "Name of the resource group that holds the whole lab."
  type        = string
  default     = "rg-hybrid-connectivity"
}

variable "name_prefix" {
  description = "Short prefix used to name globally-unique resources (storage account, etc.)."
  type        = string
  default     = "hybnet"

  validation {
    condition     = can(regex("^[a-z0-9]{3,11}$", var.name_prefix))
    error_message = "name_prefix must be 3-11 lowercase alphanumeric characters (storage account naming constraint)."
  }
}

variable "admin_username" {
  description = "Admin username for the Linux VMs."
  type        = string
  default     = "azureuser"
}

variable "admin_ssh_public_key" {
  description = "SSH public key used for VM authentication (contents of an id_rsa.pub / id_ed25519.pub)."
  type        = string
}

variable "vm_size" {
  description = "VM size for the per-VNet Linux test hosts."
  type        = string
  default     = "Standard_B1s"
}

variable "vpn_gateway_sku" {
  description = "VPN Gateway SKU. VpnGw1 is the smallest SKU that supports BGP."
  type        = string
  default     = "VpnGw1"
}

variable "vpn_shared_key" {
  description = "Pre-shared key used for the VNet-to-VNet IPsec tunnels."
  type        = string
  sensitive   = true
  default     = "ChangeMe-Pre$haredKey-2026"
}

variable "log_retention_days" {
  description = "Retention in days for the Log Analytics Workspace."
  type        = number
  default     = 30
}

variable "tags" {
  description = "Common tags applied to all resources."
  type        = map(string)
  default = {
    project     = "azure-hybrid-connectivity"
    environment = "lab"
    managed_by  = "terraform"
  }
}
