data "http" "myip" {
  url = "http://ipv4.icanhazip.com"
}

resource "random_string" "admin_pass" {
  length = 8
  lower  = true
}

// Create (boot) disk for the instance running Devstack 
resource "google_compute_disk" "devstack_boot" {
  name = "${local.prefix}-devstack-boot"
  type = "pd-ssd"
  size = var.boot_disk_size

  image = var.instance_image
}

// Create VM instance running Devstack 
resource "google_compute_instance" "devstack" {
  name         = "${local.prefix}-devstack"
  machine_type = var.instance_machine_type
  zone         = var.gcp_zone

  boot_disk {
    source = google_compute_disk.devstack_boot.name
  }

  network_interface {
    network    = google_compute_network.vpc.name
    subnetwork = google_compute_subnetwork.network_subnet.name
    access_config {
      // Include this section to give the VM an external ip address
    }
  }
  // Add devstack bootstrap userdata
  metadata_startup_script = templatefile("${path.module}/files/userdata.tpl", { admin_pass = random_string.admin_pass.result })
  // Apply the firewall rule to allow selected IPs to access devstack instance
  tags = local.tags
}

// Create VPC
resource "google_compute_network" "vpc" {
  name                    = "${local.prefix}-vpc"
  auto_create_subnetworks = "false"
  routing_mode            = "GLOBAL"
}
// Create public subnet
resource "google_compute_subnetwork" "network_subnet" {
  name          = "${local.prefix}-subnet"
  ip_cidr_range = var.network_subnet_cidr
  network       = google_compute_network.vpc.name
  region        = var.gcp_region
}

resource "google_compute_firewall" "http_server" {
  name    = "${local.prefix}-http-allow"
  network = google_compute_network.vpc.name

  allow {
    protocol = "tcp"
    ports    = ["80", "8080"]
  }

  // Allow traffic from terraform executed environment + any additional ip ranges
  source_ranges = ["0.0.0.0/0"]
  target_tags   = local.tags
}

resource "google_compute_firewall" "ssh_server" {
  name    = "${local.prefix}-ssh-allow"
  network = google_compute_network.vpc.name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  // Allow traffic from terraform executed environment + any additional ip ranges
  source_ranges = concat(
    var.ssh_access_source_ips,
    ["${chomp(data.http.myip.response_body)}/32"]
  )
  target_tags = local.tags
}
