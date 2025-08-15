# Outputs file
output "hellocloud_app_url" {
  value = "http://${aws_eip.hellocloud.public_dns}"
}

output "hellocloud_app_ip" {
  value = "http://${aws_eip.hellocloud.public_ip}"
}

output "hellocloud_instance_private_key" {
  description = "Private key for SSH access"
  value       = tls_private_key.hellocloud.private_key_openssh
  sensitive   = true
}

output "vpc_id" {
  value = aws_vpc.hellocloud.id
}

output "vpc_cidr" {
  value = aws_vpc.hellocloud.cidr_block
}

output "route_table_id" {
  value = aws_route_table.hellocloud.id
}
