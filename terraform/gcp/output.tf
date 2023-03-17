output "devstack_admin_password" {
  value = random_string.admin_pass.result
}

output "devstack_access_ip" {
  value = google_compute_instance.devstack.network_interface.0.access_config.0.nat_ip
}
