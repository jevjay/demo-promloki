terraform {
  required_version = ">= 0.14.0"
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "~> 1.48.0"
    }
  }
}

provider "openstack" {
  user_name                     = var.openstack_user
  auth_url                      = var.openstack_auth_url
  region                        = var.openstack_region
  user_id                       = var.openstack_user_id
  application_credential_id     = var.openstack_application_credential_id
  application_credential_secret = var.openstack_application_credential_secret
  tenant_id                     = var.openstack_tenant_id
  tenant_name                   = var.openstack_tenant_name
  endpoint_overrides = {
    "identity" = var.openstack_auth_url
  }
}
