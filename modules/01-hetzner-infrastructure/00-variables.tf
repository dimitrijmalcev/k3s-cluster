variable "stage" {
    type = string
    description = "stage"
}
variable "hetzner_api_token" {
    type = string
    description = "hetzner_api_token"
}
variable "hcloud_number_server_nodes" {
    type = number
    description = "hcloud_number_server_nodes"
}
variable "hcloud_number_worker_nodes" {
    type = number
    description = "hcloud_number_worker_nodes"
}
variable "hcloud_type_server_nodes" {
    type = string
    description = "hcloud_type_server_nodes"
}
variable "hcloud_type_worker_nodes" {
    type = string
    description = "hcloud_type_worker_nodes"
}
variable "hcloud_dc1" {
    type = string
    description = "hcloud_dc1"
}
variable "hcloud_dc2" {
    type = string
    description = "hcloud_dc2"
}
variable "hcloud_zone" {
    type = string
    description = "hcloud_zone"
}

variable "expose_management_protocols" {
  type = bool
  description = "expose management protocols like ssh and kubernetes api"
}

variable "ssh_public_keys" {
  type = list(string)
  description = "A List of SSH public keys"
}