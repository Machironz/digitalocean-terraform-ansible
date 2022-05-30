resource "digitalocean_droplet" "grafana" {
    image = "ubuntu-20-04-x64"
    name = var.droplet_name
    region = "sgp1"
    size = var.droplet_size
    tags = [data.digitalocean_tag.test.id]
    private_networking = true
    ssh_keys = [
      data.digitalocean_ssh_key.machiron.id
    ]
provisioner "remote-exec" {
    inline = ["sudo apt update", "sudo apt install python3 -y", "echo Done!"]

    connection {
      host        = self.ipv4_address
      type        = "ssh"
      user        = "root"
      private_key = file(var.pvt_key)
    }
  }
provisioner "local-exec" {
    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u root -i '${self.ipv4_address},' --private-key ${var.pvt_key} -e 'pub_key=${var.pub_key}' ${var.hostdocker_path} ${var.hostplaybook_path}"
  }
}
output "droplet_ip_addresses" {
  value = digitalocean_droplet.grafana.ipv4_address
}
