provider "azurerm" {
  # subscription_id is read from the ARM_SUBSCRIPTION_ID environment variable
  # (or `az login` context). It is intentionally not hard-coded here.
  subscription_id = var.subscription_id

  features {}
}

provider "random" {}
