
resource "hcloud_primary_ip" "peer_v4" {
  count         = lookup(try(var.capabilities["all"], {}), "network_peer_enable", false) ? 1 : 0
  name          = "peer-v4"
  location      = lookup(try(var.capabilities["all"], {}), "network_peer_zone", "fsn1")
  type          = "ipv4"
  assignee_type = "server"
  auto_delete   = false
}

resource "hcloud_primary_ip" "peer_v6" {
  count         = lookup(try(var.capabilities["all"], {}), "network_peer_enable", false) ? 1 : 0
  name          = "peer-v6"
  location      = lookup(try(var.capabilities["all"], {}), "network_peer_zone", "fsn1")
  type          = "ipv6"
  assignee_type = "server"
  auto_delete   = false
}

resource "hcloud_server" "peer" {
  count       = lookup(try(var.capabilities["all"], {}), "network_peer_enable", false) ? 1 : 0
  location    = lookup(try(var.capabilities["all"], {}), "network_peer_zone", "fsn1")
  server_type = lookup(try(var.capabilities["all"], {}), "network_peer_type", "cx23")

  name     = "router-${lookup(try(var.capabilities["all"], {}), "network_peer_zone", "fsn1")}"
  image    = "debian-13"
  ssh_keys = [var.ssh_key_id]
  labels   = merge(var.tags, { type = "infra", label = "peer" })

  firewall_ids = [hcloud_firewall.common.id, hcloud_firewall.peer.id]
  public_net {
    ipv4_enabled = true
    ipv4         = hcloud_primary_ip.peer_v4[0].id
    ipv6_enabled = true
    ipv6         = hcloud_primary_ip.peer_v6[0].id
  }
  network {
    network_id = hcloud_network.main.id
    ip         = cidrhost(hcloud_network_subnet.public.ip_range, 2)
  }

  shutdown_before_deletion = true
  lifecycle {
    ignore_changes = [
      delete_protection,
      rebuild_protection,
      network,
      image,
      server_type,
      user_data,
      ssh_keys,
    ]
  }
}
