output "server_ips" {
    value = [ for vm in var.proxmox_vms : vm.ip_address if can(regex("server",vm.vm_name))]
}

output "worker_ips" {
    value = [ for vm in var.proxmox_vms : vm.ip_address if can(regex("worker",vm.vm_name))]
}

output "server_internal_ips" {
    value = [ for vm in var.proxmox_vms : vm.ip_address if can(regex("server",vm.vm_name))]
}

output "worker_internal_ips" {
   value = [ for vm in var.proxmox_vms : vm.ip_address if can(regex("worker",vm.vm_name))]
}

output "ssh_user" {
  value = "root"
}