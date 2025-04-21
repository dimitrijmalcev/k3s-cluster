output "server_ips" {
    value = hcloud_server.server[*].ipv4_address
}

output "worker_ips" {
    value = hcloud_server.worker[*].ipv4_address
}

output "server_internal_ips" {
    description = "Internal IPs of the hcloud servers"
    value = [for i in range(var.hcloud_number_server_nodes) : "10.0.0.${i+4}"]
}

output "worker_internal_ips" {
    description = "Internal IPs of the hcloud servers"
    value = [for i in range(var.hcloud_number_worker_nodes) : "10.0.0.${i+104}"]
}

output "ssh_user" {
    value = "root"
}
