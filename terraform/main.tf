# main.tf
provider "digitalocean" {
  token = "dop_v1_90b25d425f4e1e6059c670bee45e830521e8fc80cfb4f9853685dac013a68738"
}
resource "digitalocean_droplet" "example" {
  image  = "ubuntu-24-10-x64"
  name   = "example-droplet"
  region = "lon1"  # Use your preferred region
  size   = "s-1vcpu-2gb"
  ssh_keys = ["HNG"]  # Replace with your SSH key ID
}
resource "digitalocean_firewall" "example" {
  name    = "example-firewall"
  droplet_ids = ["example_id"]  # This attaches the firewall to your droplet
  inbound_rule {
    protocol   = "tcp"
    port_range = "22"
    cidr_blocks = ["0.0.0.0/0"]
  }
  inbound_rule {
    protocol   = "tcp"
    port_range = "80"
    cidr_blocks = ["0.0.0.0/0"]
  }
    inbound_rule {
    protocol    = "tcp"
    port_range  = "443"
    cidr_blocks = ["0.0.0.0/0"]
  }
  outbound_rule {
    protocol   = "tcp"
    port_range = "80"
    cidr_blocks = ["0.0.0.0/0"]
  }
  outbound_rule {
    protocol   = "tcp"
    port_range = "22"
    cidr_blocks = ["0.0.0.0/0"]
  }
  outbound_rule {
    protocol   = "tcp"
    port_range = "1-65535"
    cidr_blocks = ["0.0.0.0/0"]
  }
  outbound_rule {
    protocol    = "udp"
    port_range  = "1-65535"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
output "droplet_ip" {
  value = digitalocean_droplet.example.ipv4_address
}
output "droplet_id" {
  value = digitalocean_droplet.example.id
}
