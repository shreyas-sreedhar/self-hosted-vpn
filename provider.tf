terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

variable "do_token" {}
variable "ssh_key_name" {}

provider "digitalocean" {
  token = var.do_token
}
resource "digitalocean_droplet" "vpn_proxy" {
  image    = "ubuntu-22-04-x64"
  name     = "indian-vpn-proxy"
  region   = "blr1"  # Bangalore (India)
  size     = "s-1vcpu-1gb"  # $6/month
  ssh_keys = [data.digitalocean_ssh_key.main.fingerprint]

  # Userdat to install WireGuard and configure on startup
  user_data = file("setup.sh")
}

data "digitalocean_ssh_key" "main" {
  name = var.ssh_key_name
}
output "server_ip" {
  value = digitalocean_droplet.vpn_proxy.ipv4_address
}