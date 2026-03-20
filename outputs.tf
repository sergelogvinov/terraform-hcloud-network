
output "regions" {
  description = "Regions"
  value       = var.regions
}

output "network_public" {
  description = "The public network"
  value = { for idx, zone in var.regions : zone => {
    network_id = hcloud_network_subnet.public.network_id
    subnet_id  = hcloud_network_subnet.public.id
    cidr_v4    = hcloud_network_subnet.public.ip_range
    cidr_v6    = ""
    gateway_v4 = cidrhost(hcloud_network_subnet.public.ip_range, 1)
    gateway_v6 = ""
    mtu        = 1500
  } }
}

output "network_private" {
  description = "The private network"
  value = { for idx, zone in var.regions : zone => {
    network_id = hcloud_network_subnet.private.network_id
    subnet_id  = hcloud_network_subnet.private.id
    cidr_v4    = hcloud_network_subnet.private.ip_range
    cidr_v6    = ""
    gateway_v4 = cidrhost(hcloud_network_subnet.private.ip_range, 1)
    gateway_v6 = ""
    mtu        = 1500
  } }
}

output "network_baremetal" {
  description = "The baremetal network"
  value = { for idx, zone in var.regions : zone => {
    network_id = hcloud_network_subnet.robot[0].network_id
    subnet_id  = hcloud_network_subnet.robot[0].id
    cidr_v4    = hcloud_network_subnet.robot[0].ip_range
    cidr_v6    = ""
    gateway_v4 = cidrhost(hcloud_network_subnet.robot[0].ip_range, 1)
    gateway_v6 = ""
    mtu        = 1400
  } if var.network_vswitch > 0 }
}

output "network_nat" {
  description = "The nat ips"
  value = { for idx, zone in var.regions : zone => {
    ip_v4 = hcloud_primary_ip.peer_v4[0].ip_address
    ip_v6 = cidrhost(hcloud_primary_ip.peer_v6[0].ip_network, 2)
  } if lookup(try(var.capabilities["all"], {}), "network_peer_enable", false) }
}

output "network_secgroup" {
  description = "The Network Security Groups"
  value = { for idx, zone in var.regions : zone => {
    common          = hcloud_firewall.common.id
    controlplane    = hcloud_firewall.controlplane.id
    controlplane_lb = hcloud_firewall.controlplane_lb.id
  } }
}
