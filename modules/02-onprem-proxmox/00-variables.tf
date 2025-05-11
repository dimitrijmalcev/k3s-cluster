
variable "ssh_public_keys" {
  type = list(string)
}

variable "proxmox_api_url" {
    type = string
}

variable "proxmox_api_user" {
    type = string
}

variable "proxmox_api_password" {
    type = string
}

variable "proxmox_vms" {
    type = list(object({
        image_id = string
        proxmox_node = string
        vm_name = string
        ip_address = string
        gateway = string
        memory = number
        cpu = number
    }))
}
