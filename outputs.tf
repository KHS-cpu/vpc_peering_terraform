# Outputs file
output "hellocloud_app_url" {
  value = module.srvr-1.hellocloud_app_url
}

output "hellocloud_app_ip" {
  value = module.srvr-1.hellocloud_app_ip
}

output "hellocloud_instance_private_key" {
  description = "Private key for SSH access"
  value       = module.srvr-1.hellocloud_instance_private_key
  sensitive   = true
}

# Outputs file
output "hellocloud_app_url_2" {
  value = module.srvr-2.hellocloud_app_url
}

output "hellocloud_app_ip_2" {
  value = module.srvr-2.hellocloud_app_ip
}

output "hellocloud_instance_private_key_2" {
  description = "Private key for SSH access"
  value       = module.srvr-2.hellocloud_instance_private_key
  sensitive   = true
}