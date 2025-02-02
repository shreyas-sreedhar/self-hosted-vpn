terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

variable "do_token" {
    type = string
}
variable "ssh_key_name" {
    type = string
}

provider "digitalocean" {
  token = var.do_token
}


resource "digitalocean_droplet" "vpn_proxy" {
  image    = "openvpn-18-04"
  name     = "indian-openvpn"
  region   = "blr1"  # Bangalore (India)
  size     = "s-1vcpu-1gb"  # $6/month
  ssh_keys = [data.digitalocean_ssh_key.main.fingerprint]

}

data "digitalocean_ssh_key" "main" {
  name = var.ssh_key_name
}
output "server_ip" {
  value = digitalocean_droplet.vpn_proxy.ipv4_address
}