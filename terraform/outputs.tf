output "all_instance_public_ips" {
  value       = module.nova.instance_public_ips
  description = "The public IPs of all instances created by the module"
}

