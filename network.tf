
locals {
  network_cidr_v4 = var.network_cidr[0] # cidrsubnet(var.network_cidr[0], 6, var.network_shift)
  network_cidr_v6 = var.network_cidr[1]
}

resource "hcloud_network" "main" {
  name     = var.network_name
  ip_range = local.network_cidr_v4
  labels   = merge(var.tags, { type = "infra" })
}

resource "hcloud_network_subnet" "public" {
  network_id   = hcloud_network.main.id
  type         = "cloud"
  network_zone = "eu-central"
  ip_range     = cidrsubnet(hcloud_network.main.ip_range, 8, var.network_shift * 4)
}

resource "hcloud_network_subnet" "private" {
  network_id   = hcloud_network.main.id
  type         = "cloud"
  network_zone = "eu-central"
  ip_range     = cidrsubnet(hcloud_network.main.ip_range, 8, var.network_shift * 4 + 1)
}

resource "hcloud_network_subnet" "robot" {
  count        = var.network_vswitch == 0 ? 0 : 1
  network_id   = hcloud_network.main.id
  type         = "vswitch"
  network_zone = "eu-central"
  vswitch_id   = var.network_vswitch
  ip_range     = cidrsubnet(hcloud_network.main.ip_range, 8, var.network_shift * 4 + 2)
}

# resource "hcloud_network_route" "peer" {
#   count = lookup(try(var.capabilities["all"], {}), "network_peer_enable", false) ? 1 : 0

#   network_id  = hcloud_network.main.id
#   destination = var.network_cidr[0]
#   gateway     = cidrhost(hcloud_network_subnet.public.ip_range, 2)
# }
