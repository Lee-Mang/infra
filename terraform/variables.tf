variable "example_id" {
  description = "The ID of the droplet"
  type        = string
}

variable "do_token" {
  description = "The DigitalOcean API token"
  type        = string
}

variable "do_example_size" {
  type        = string
  description = "Size of the server droplet"
}

variable "do_example_image" {
  type        = string
  description = "Image to use for the server droplet"
}

variable "do_region" {
  type        = string
  description = "DigitalOcean region for the droplets"
}

variable "ssh_port" {
  type        = number
  description = "SSH port for the server"
  validation {
    condition     = var.ssh_port >= 22 && var.ssh_port <= 65535  # Directly define min/max range
    error_message = "ssh_port must be between 22 and 65535"
  }
}

variable "environment" {
  type        = string
  description = "Environment name (e.g., prod, staging, dev)"
}

variable "ssh_port_range" {
  type = object({
    min = number
    max = number
  })
  description = "Valid range for SSH ports"
  default = {
    min = 22
    max = 65535
  }
}

