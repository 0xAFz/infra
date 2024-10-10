output "instance_public_ips" {
  value       = openstack_compute_instance_v2.instance[*].access_ip_v4
  description = "The public IPs of all instances"
}

