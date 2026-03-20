
resource "hcloud_ssh_key" "infra" {
  name       = "infra"
  public_key = var.ssh_key
  labels     = merge(var.tags, { type = "infra" })
}
