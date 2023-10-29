terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

# resource "digitalocean_ssh_key" "pernonal_use" {
# name       = "SSH_KEY"
# public_key = file("./.ssh/id_rsa.pub")
# }

provider "digitalocean" {
  token = ""
}

resource "digitalocean_droplet" "pernonal_use" {
  image    = "ubuntu-22-04-x64"
  name     = "teelyjc"
  region   = "sgp1"
  size     = "s-1vcpu-1gb"
  ssh_keys = [digitalocean_ssh_key.pernonal_use.fingerprint]

  connection {
    type        = "ssh"
    host        = self.ipv4_address
    user        = "root"
    private_key = file(".ssh/id_rsa")
  }

  provisioner "file" {
    source      = "./scripts/docker.sh"
    destination = "/tmp/docker.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/docker.sh",
      "/tmp/docker.sh"
    ]
  }
}
