terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

variable "do_token" {}
variable "pvt_key" {
  default = "/root/private.key"
}
variable "pub_key" {
  default = "/root/.ssh/authorized_keys"
}
variable "droplet_name" {}
variable "droplet_size" {
  default = "s-2vcpu-4gb"
}
variable "hostdocker_path" {}
#variable "clientdocker_path" {}
variable "hostplaybook_path" {}
#variable "clientplaybook_path" {}



provider "digitalocean" {
  token = var.do_token
}

data "digitalocean_ssh_key" "machiron" {
  name = "machiron"
}
data "digitalocean_tag" "test" {
  name = "test"
}
