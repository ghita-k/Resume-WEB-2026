# AGENTS.md

## Cursor Cloud specific instructions

### Repository overview

This repo hosts cloud/DevOps portfolio projects. Current contents:

- `azure-hybrid-connectivity/` — Terraform IaC for a multi-site Azure network
  (3 VNets, VPN Gateways with BGP in a chained topology, NSGs, Log Analytics +
  Storage for monitoring, one Linux VM per VNet). See its `README.md` for the
  full architecture and the standard `init` / `fmt` / `validate` / `plan` /
  `apply` / `destroy` workflow.

### Toolchain (already present in the VM snapshot)

- `terraform` (installed from the HashiCorp apt repo) and `az` (Azure CLI) are
  preinstalled. If either is ever missing, reinstall terraform via the HashiCorp
  apt repo and Azure CLI via `https://aka.ms/InstallAzureCLIDeb`.
- The startup update script runs `terraform init -backend=false -upgrade` inside
  `azure-hybrid-connectivity/` to refresh provider plugins. This is the
  "dependency install" step for the Terraform code.

### Non-obvious caveats

- **Lint/validate work fully offline** — no Azure account needed:
  `cd azure-hybrid-connectivity && terraform fmt -check -recursive && terraform validate`.
- **`terraform plan`/`apply` require live Azure credentials.** Without them,
  `plan` deliberately stops at the `azurerm` provider auth step
  (`Please run 'az login'`); this is expected, not a code error. To deploy,
  `az login` and set `ARM_SUBSCRIPTION_ID` (or the `subscription_id` variable).
- `admin_ssh_public_key` is a **required variable with no default**. For offline
  `plan` experiments, set it via `TF_VAR_admin_ssh_public_key="$(cat some_key.pub)"`.
- **Cost/time warning:** applying provisions three VPN Gateways (`VpnGw1`), which
  are billed hourly and each take ~30–45 minutes to create and to delete. Run
  `terraform destroy` when finished.
- The `.terraform/` dir and `*.tfstate` / `*.tfvars` are git-ignored (see
  `azure-hybrid-connectivity/.gitignore`); the provider lock file
  `.terraform.lock.hcl` is committed on purpose.
