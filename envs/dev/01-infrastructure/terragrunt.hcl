include {
    path = find_in_parent_folders("root.hcl")
}

locals {
    env_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
}

terraform {
    source = (
        local.env_vars.inputs.cloud_infrastructure_provider == "hetzner" ? "../../../modules/01-hetzner-infrastructure" 
        : local.env_vars.inputs.cloud_infrastructure_provider == "aws" ? "../../../modules/02-aws-infrastructure" 
        : local.env_vars.inputs.cloud_infrastructure_provider == "onprem-proxmox" ? "../../../modules/02-onprem-proxmox" 
        : local.env_vars.inputs.cloud_infrastructure_provider == "onprem-simple" ? "../../../modules/02-onprem-infrastructure" 
        : "../../../modules/99-empty-module" 
    )
    copy_terraform_lock_file = false
}

inputs = merge(
    local.env_vars.inputs,
    {
        
    }
)
