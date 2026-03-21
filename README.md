# Terraform module for Heznet Cloud

## Overview

## Usage Example

```hcl
module "network" {
  source = "github.com/sergelogvinov/terraform-hcloud-network"

  regions = ["fsn1", "nbg1"]

  network_name    = "main"
  network_cidr    = ["172.16.0.0/16", "fd60:172:16::/56"]
  network_shift   = 2

  allowlist_datacenters = ["123.123.123.0/24"]
  allowlist_admins      = ["1.2.3.4/32"]

  tags = {
    environment = "rnd"
  }
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5 |
| <a name="requirement_hcloud"></a> [hcloud](#requirement\_hcloud) | >= 1.60.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_hcloud"></a> [hcloud](#provider\_hcloud) | 1.60.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [hcloud_firewall.common](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/firewall) | resource |
| [hcloud_firewall.controlplane](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/firewall) | resource |
| [hcloud_firewall.controlplane_lb](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/firewall) | resource |
| [hcloud_firewall.peer](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/firewall) | resource |
| [hcloud_firewall.web](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/firewall) | resource |
| [hcloud_network.main](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/network) | resource |
| [hcloud_network_subnet.private](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/network_subnet) | resource |
| [hcloud_network_subnet.public](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/network_subnet) | resource |
| [hcloud_network_subnet.robot](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/network_subnet) | resource |
| [hcloud_primary_ip.peer_v4](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/primary_ip) | resource |
| [hcloud_primary_ip.peer_v6](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/primary_ip) | resource |
| [hcloud_server.peer](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/server) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allowlist_admins"></a> [allowlist\_admins](#input\_allowlist\_admins) | Whitelist for administrators | `list` | <pre>[<br/>  "0.0.0.0/0"<br/>]</pre> | no |
| <a name="input_allowlist_datacenters"></a> [allowlist\_datacenters](#input\_allowlist\_datacenters) | Datacenters subnets | `list` | `[]` | no |
| <a name="input_capabilities"></a> [capabilities](#input\_capabilities) | n/a | `map(any)` | <pre>{<br/>  "all": {<br/>    "network_peer_enable": false,<br/>    "network_peer_type": "cx23",<br/>    "network_peer_zone": "fsn1"<br/>  }<br/>}</pre> | no |
| <a name="input_network_cidr"></a> [network\_cidr](#input\_network\_cidr) | Local subnet rfc1918 | `list(string)` | <pre>[<br/>  "172.29.0.0/16",<br/>  "fd60:172:29::/56"<br/>]</pre> | no |
| <a name="input_network_name"></a> [network\_name](#input\_network\_name) | n/a | `string` | `"main"` | no |
| <a name="input_network_shift"></a> [network\_shift](#input\_network\_shift) | Network number shift | `number` | `1` | no |
| <a name="input_network_vswitch"></a> [network\_vswitch](#input\_network\_vswitch) | n/a | `number` | `0` | no |
| <a name="input_regions"></a> [regions](#input\_regions) | The id of the hezner region (order is important) | `list(string)` | <pre>[<br/>  "fsn1",<br/>  "nbg1",<br/>  "hel1"<br/>]</pre> | no |
| <a name="input_ssh_key_id"></a> [ssh\_key\_id](#input\_ssh\_key\_id) | HCloud ssh public key id | `number` | `0` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags of resources | `map(string)` | <pre>{<br/>  "environment": "develop"<br/>}</pre> | no |
| <a name="input_whitelist_web"></a> [whitelist\_web](#input\_whitelist\_web) | Cloudflare subnets | `list` | <pre>[<br/>  "173.245.48.0/20",<br/>  "103.21.244.0/22",<br/>  "103.22.200.0/22",<br/>  "103.31.4.0/22",<br/>  "141.101.64.0/18",<br/>  "108.162.192.0/18",<br/>  "190.93.240.0/20",<br/>  "188.114.96.0/20",<br/>  "197.234.240.0/22",<br/>  "198.41.128.0/17",<br/>  "162.158.0.0/15",<br/>  "104.16.0.0/13",<br/>  "104.24.0.0/14",<br/>  "172.64.0.0/13",<br/>  "131.0.72.0/22"<br/>]</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_network_baremetal"></a> [network\_baremetal](#output\_network\_baremetal) | The baremetal network |
| <a name="output_network_nat"></a> [network\_nat](#output\_network\_nat) | The nat ips |
| <a name="output_network_private"></a> [network\_private](#output\_network\_private) | The private network |
| <a name="output_network_public"></a> [network\_public](#output\_network\_public) | The public network |
| <a name="output_network_secgroup"></a> [network\_secgroup](#output\_network\_secgroup) | The Network Security Groups |
| <a name="output_regions"></a> [regions](#output\_regions) | Regions |
<!-- END_TF_DOCS -->