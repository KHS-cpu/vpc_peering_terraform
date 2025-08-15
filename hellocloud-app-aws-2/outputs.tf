# Outputs file
output "hellocloud_app_url" {
  value = module.my-app-aws.hellocloud_app_url
}

output "hellocloud_app_ip" {
  value = module.my-app-aws.hellocloud_app_ip
}

output "hellocloud_instance_private_key" {
  description = "Private key for SSH access"
  value       = module.my-app-aws.hellocloud_instance_private_key
  sensitive   = true
}


output "vpc_id" {
  value = module.my-app-aws.vpc_id
}

output "vpc_cidr" {
  value = module.my-app-aws.vpc_cidr
}

output "route_table_id" {
  value = module.my-app-aws.route_table_id
}