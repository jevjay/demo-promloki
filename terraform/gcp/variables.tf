// === REQUIRED ===

variable "gcp_project" {
  type = string
}

variable "gcp_region" {
  type = string
}

variable "gcp_zone" {
  type = string
}

// === OPTIONAL ===

variable "instance_machine_type" {
  type    = string
  default = "e2-standard-2"
}

variable "instance_image" {
  type    = string
  default = "ubuntu-os-cloud/ubuntu-2204-lts"
}

variable "http_access_source_ips" {
  type    = list(any)
  default = []
}

variable "ssh_access_source_ips" {
  type    = list(any)
  default = []
}

variable "network_subnet_cidr" {
  type    = string
  default = "10.0.0.0/29"
}

variable "boot_disk_size" {
  type    = string
  default = 80
}
