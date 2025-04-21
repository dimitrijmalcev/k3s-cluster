locals {
    env_name    = dirname(path_relative_to_include()) # dev
    module_name = basename(get_terragrunt_dir()) # 01-infrastructure
    state_path = "${get_repo_root()}/envs/../state/${local.env_name}/${local.module_name}.tfstate"
}

remote_state{
    backend = "local"
    config = {
        path = local.state_path
    }
}