output "public_ips" {
  value       = module.vm.instance_public_ips
  description = "The public IPs of all instances created by vm module"
}

output "dns_records" {
  description = "The DNS records created for instances created by dns module"
  value = module.dns.dns_records
}

