
resource "hcloud_firewall" "common" {
  name   = "common"
  labels = merge(var.tags, { type = "infra" })

  rule {
    direction  = "in"
    protocol   = "icmp"
    source_ips = concat(var.allowlist_admins, [var.network_cidr[0], "::/0"])
  }
  rule {
    direction  = "in"
    protocol   = "udp"
    port       = "any"
    source_ips = [var.network_cidr[0]]
  }
  rule {
    direction  = "in"
    protocol   = "tcp"
    port       = "any"
    source_ips = [var.network_cidr[0]]
  }

  rule {
    direction  = "in"
    protocol   = "tcp"
    port       = "50000"
    source_ips = var.allowlist_admins
  }

  # cilium health
  rule {
    direction  = "in"
    protocol   = "tcp"
    port       = "4240"
    source_ips = ["::/0"]
  }
}

resource "hcloud_firewall" "controlplane" {
  name   = "controlplane"
  labels = merge(var.tags, { type = "infra", label = "controlplane" })

  rule {
    direction  = "in"
    protocol   = "tcp"
    port       = "50000"
    source_ips = var.allowlist_admins
  }

  rule {
    direction  = "in"
    protocol   = "tcp"
    port       = "2379"
    source_ips = ["0.0.0.0/0"]
  }
  rule {
    direction  = "in"
    protocol   = "tcp"
    port       = "2380"
    source_ips = ["0.0.0.0/0"]
  }
  rule {
    direction  = "in"
    protocol   = "tcp"
    port       = "6443"
    source_ips = var.allowlist_admins
  }
}

resource "hcloud_firewall" "controlplane_lb" {
  name   = "controlplane-lb"
  labels = merge(var.tags, { type = "infra", label = "controlplane" })

  rule {
    direction  = "in"
    protocol   = "tcp"
    port       = "50000"
    source_ips = ["0.0.0.0/0"]
  }
  rule {
    direction  = "in"
    protocol   = "tcp"
    port       = "50001"
    source_ips = ["0.0.0.0/0"]
  }
  rule {
    direction  = "in"
    protocol   = "tcp"
    port       = "6443"
    source_ips = ["0.0.0.0/0"]
  }
}

resource "hcloud_firewall" "web" {
  name   = "web"
  labels = merge(var.tags, { type = "infra", label = "web" })

  rule {
    direction  = "in"
    protocol   = "tcp"
    port       = "80"
    source_ips = var.whitelist_web
  }
  rule {
    direction  = "in"
    protocol   = "tcp"
    port       = "443"
    source_ips = var.whitelist_web
  }
}

resource "hcloud_firewall" "peer" {
  name   = "peer"
  labels = merge(var.tags, { type = "infra", label = "peer" })

  rule {
    direction  = "in"
    protocol   = "tcp"
    port       = "22"
    source_ips = var.allowlist_admins
  }
}
