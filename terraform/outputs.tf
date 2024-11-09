output "public_ips" {
  value       = module.vm.instance_public_ips
  description = "The public IPs of all instances created by vm module"
}

locals {
  dns_records_to_output = var.use_dns && length(module.dns) > 0 ? flatten([for record in module.dns : record.dns_records]) : []
}

output "dns_records" {
  description = "The DNS records created for instances created by dns module"
  value       = local.dns_records_to_output
}

