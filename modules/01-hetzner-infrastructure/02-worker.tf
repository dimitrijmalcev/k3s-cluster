resource "hcloud_server" "worker" {
  count = var.hcloud_number_worker_nodes
  name        = "${var.stage}-worker-${count.index}"
  image       = "rocky-9"
  server_type = var.hcloud_type_worker_nodes
  datacenter  = (count.index+1) % 2 == 0 ? var.hcloud_dc1 : var.hcloud_dc2
  public_net {
    ipv4_enabled = true
    ipv6_enabled = false
  }
  network {
    network_id = hcloud_network.privNet.id
    ip = "10.0.0.${count.index+104}"
  }
  
  ssh_keys = [for key in hcloud_ssh_key.this : key.name ]

  firewall_ids = var.expose_management_protocols == true ? [ hcloud_firewall.firewall_egress_tcp_any.id, hcloud_firewall.internal_tcp_udp_allow_all.id,  hcloud_firewall.firewall_ingress_ssh.id,hcloud_firewall.firewall_ingress_api.id] : [hcloud_firewall.firewall_egress_tcp_any.id, hcloud_firewall.internal_tcp_udp_allow_all.id]

  user_data = file("userdata.sh")
}