output "server_ips" {
    value = aws_instance.server[*].public_ip
}

output "worker_ips" {
    value = aws_instance.worker[*].public_ip
}

output "server_internal_ips" {
    value = aws_instance.server[*].private_ip
}

output "worker_internal_ips" {
    value = aws_instance.worker[*].private_ip
}

output "ssh_user" {
  value = "root"
}