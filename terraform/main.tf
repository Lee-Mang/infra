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
  name = "example-firewall"
  
  inbound_rule {
    protocol          = "tcp"
    from_port         = 80      # Starting port
    to_port           = 80      # Ending port (same as from_port for single port)
    source_addresses  = ["0.0.0.0/0"]  # Allow from all IP addresses
  }

  inbound_rule {
    protocol          = "tcp"
    from_port         = 443     # Starting port
    to_port           = 443     # Ending port (same as from_port for single port)
    source_addresses  = ["0.0.0.0/0"]  # Allow from all IP addresses
  }

  outbound_rule {
    protocol             = "tcp"
    from_port            = 80      # Allow egress on port 80
    to_port              = 80
    destination_addresses = ["0.0.0.0/0"]  # Allow outgoing to all IP addresses
  }

  outbound_rule {
    protocol             = "tcp"
    from_port            = 443     # Allow egress on port 443
    to_port              = 443
    destination_addresses = ["0.0.0.0/0"]  # Allow outgoing to all IP addresses
  }

  droplet_ids = [digitalocean_droplet.example.id]  # Reference to your droplet
}

output "droplet_ip" {
  value = digitalocean_droplet.example.ipv4_address
}
output "droplet_id" {
  value = digitalocean_droplet.example.id
}
