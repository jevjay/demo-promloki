// Retrieve Debian "Buster" data from Openstack platform
data "openstack_images_image_v2" "debian-buster" {
  name        = "debian-buster"
  most_recent = true
}

// Generate Openstack compute flavor based on user input (optional)
resource "openstack_compute_flavor_v2" "example" {
  name  = "${local.prefix}-flavor"
  ram   = var.compute_flavor_memory
  vcpus = var.compute_flavor_vcpus
  disk  = var.compute_flavor_disk
}

resource "openstack_compute_keypair_v2" "example" {
  name       = "${local.prefix}-keypair"
  public_key = file(var.ssh_pub_key)
}

resource "openstack_compute_instance_v2" "example" {
  name      = "${local.prefix}-example-node"
  image_id  = data.openstack_images_image_v2.debian-buster.id
  flavor_id = openstack_compute_flavor_v2.example.id
  key_pair  = openstack_compute_keypair_v2.example.name

  security_groups = [
    openstack_networking_secgroup_v2.example.name
  ]

  user_data = file("${path.module}/files/userdata")

  metadata = local.prometheus_meta

  network {
    name = "test"
  }
}

resource "openstack_networking_floatingip_v2" "example-fip" {
  pool = "external"
}

resource "openstack_compute_floatingip_associate_v2" "example-fip" {
  floating_ip = openstack_networking_floatingip_v2.example-fip.address
  instance_id = openstack_compute_instance_v2.example.id
}

resource "openstack_networking_secgroup_v2" "example" {
  name        = "${local.prefix}-sg"
  description = "Security Group used for Prometheus & Loki monitoring demo"
}

resource "openstack_networking_secgroup_rule_v2" "node_exporter" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 9100
  port_range_max    = 9100
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.example.id
}

resource "openstack_networking_secgroup_rule_v2" "ssh" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 22
  port_range_max    = 22
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.example.id
}

resource "openstack_networking_secgroup_rule_v2" "icmp_v4" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "icmp"
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.example.id
}
