terraform {
  required_providers {
    proxmox = {
      source = "bpg/proxmox"
      version = "0.77.0"
    }
  }
}

provider "proxmox" {
    endpoint = var.proxmox_api_url
    username = var.proxmox_api_user
    password = var.proxmox_api_password
    insecure = true

    ssh {
        agent = false
        username = "root"
        private_key = file("~/.ssh/id_rsa")
    }
}