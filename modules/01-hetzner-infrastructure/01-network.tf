resource "hcloud_network" "privNet" {
  name     = "${var.stage}-network"
  ip_range = "10.0.0.0/16"
}

resource "hcloud_network_subnet" "subnet1" {
  network_id   = hcloud_network.privNet.id
  type         = "cloud"
  network_zone = var.hcloud_zone
  ip_range     = "10.0.0.0/24"
  depends_on = [ 
    hcloud_network.privNet 
    ]
}

resource "hcloud_firewall" "firewall_egress_tcp_any" {
  name = "${var.stage}-egress-tcp-any"
  rule {
    direction = "out"
    protocol  = "tcp"
    port = "any"
    destination_ips = [
      "0.0.0.0/0",
      "::/0"
    ]
  }
}

resource "hcloud_firewall" "internal_tcp_udp_allow_all" {
  name = "${var.stage}-internal-udp-tcp-all"
    rule {
        direction = "out"
        protocol  = "tcp"
        port = "any"
        destination_ips = [
        "10.0.0.0/24"
        ]
    }
    rule {
        direction = "in"
        protocol  = "tcp"
        port = "any"
        source_ips = [
            "10.0.0.0/24"
        ]
    }
    rule {
        direction = "out"
        protocol  = "udp"
        port = "any"
        destination_ips = [
        "10.0.0.0/24"
        ]
    }
    rule {
        direction = "in"
        protocol  = "udp"
        port = "any"
        source_ips = [
            "10.0.0.0/24"
        ]
    }
}

resource "hcloud_firewall" "firewall_ingress_ssh" {
   name = "${var.stage}-ingress-ssh"
   rule {
        direction = "in"
        protocol  = "tcp"
        port = "22"
        source_ips = [
            "0.0.0.0/0",
            "::/0"
        ]
    }
}

resource "hcloud_firewall" "firewall_ingress_api" {
   name = "${var.stage}-ingress-api"
   rule {
        direction = "in"
        protocol  = "tcp"
        port = "6443"
        source_ips = [
            "0.0.0.0/0",
            "::/0"
        ]
    }
}

resource "hcloud_firewall" "firewall_ingress_https" {
   name = "${var.stage}-ingress-https"
   rule {
        direction = "in"
        protocol  = "tcp"
        port = "443"
        source_ips = [
            "0.0.0.0/0",
            "::/0"
        ]
    }
}
