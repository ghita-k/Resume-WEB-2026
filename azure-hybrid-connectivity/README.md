# Azure Hybrid Connectivity — VPN Gateway, BGP & Monitoring (Terraform)

Infrastructure-as-Code reproduction of a **multi-site Azure networking lab**:
three Virtual Networks connected in a **chained VNet-to-VNet topology** with
**BGP dynamic routing** and **centralized monitoring**.

> This is the Terraform version of a hands-on Azure project originally built in
> the portal. It lets you deploy, tear down and review the whole environment
> reproducibly.

## Architecture

```
                 BGP                         BGP
   VNet1  <===============>  VNet2  <===============>  VNet3
 (10.1.0.0/16)            (10.2.0.0/16)            (10.3.0.0/16)
  ASN 65001                ASN 65002                ASN 65003

   * No direct VNet1 <-> VNet3 link. VNet1 reaches VNet3 only through
     routes learned dynamically via BGP through VNet2 (chained topology).
```

Each VNet ("site") contains:

- `subnet1`, `subnet2`, and the mandatory `GatewaySubnet`
- an extra address space + `subnet-bgp-validation` subnet to validate BGP route
  learning/propagation (objective-05)
- a Network Security Group (SSH allowed **only** on VNet1 as a controlled entry
  point; ICMP allowed everywhere for ping tests)
- a Public IP + **VPN Gateway** (`VpnGw1`, route-based, BGP enabled)
- a diagnostic setting streaming gateway logs/metrics to Log Analytics + Storage
- one **Linux VM** (Ubuntu 22.04) for end-to-end reachability testing

Shared monitoring foundation:

- a **Log Analytics Workspace** (centralized logging)
- a **Storage Account** (diagnostics archival)

The `main` topology creates **47 resources** in total.

## Layout

| File | Purpose |
|------|---------|
| `versions.tf` / `providers.tf` | Terraform + provider requirements and config |
| `variables.tf` / `outputs.tf` | Root inputs and outputs |
| `main.tf` | Resource group + monitoring (Log Analytics, Storage) |
| `vnets.tf` | Three `vnet_site` module instances |
| `connections.tf` | Four VNet-to-VNet BGP connections |
| `modules/vnet_site/` | Reusable per-site module (VNet, NSG, gateway, VM, diag) |

## Prerequisites

- Terraform >= 1.5 (developed with 1.15)
- Azure CLI (`az`) authenticated: `az login`
- An Azure subscription (VPN Gateways are billed hourly and take ~30–45 min each
  to provision)

## Usage

```bash
cd azure-hybrid-connectivity

# 1. Authenticate
az login
export ARM_SUBSCRIPTION_ID="<your-subscription-id>"

# 2. Provide inputs
cp terraform.tfvars.example terraform.tfvars
#   -> set admin_ssh_public_key (and optionally override defaults)

# 3. Standard workflow
terraform init
terraform fmt -check -recursive
terraform validate
terraform plan
terraform apply

# When done (VPN Gateways are expensive — don't leave them running):
terraform destroy
```

## Offline development (no Azure subscription)

You can fully develop and lint the code without any Azure credentials:

```bash
terraform init -backend=false
terraform fmt -check -recursive
terraform validate
```

`terraform plan`/`apply` require a live subscription and `az login`.
