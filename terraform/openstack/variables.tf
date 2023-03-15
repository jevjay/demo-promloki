// === REQUIRED ===

variable "openstack_auth_url" {
  type = string
}

variable "openstack_user_id" {
  type = string
}

variable "openstack_application_credential_id" {
  type = string
}

variable "openstack_application_credential_secret" {
  type = string
}

variable "openstack_tenant_id" {
  type = string
}

variable "openstack_tenant_name" {
  type = string
}

variable "ssh_pub_key" {
  type = string
}

// === OPTIONAL ===

variable "openstack_user" {
  type    = string
  default = "admin"
}

variable "openstack_region" {
  type    = string
  default = "RegionOne"
}

variable "compute_flavor_memory" {
  type    = string
  default = "8096"
}

variable "compute_flavor_vcpus" {
  type    = string
  default = "2"
}

variable "compute_flavor_disk" {
  type    = string
  default = "64"
}
