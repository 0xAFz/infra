output "dns_records" {
  description = "The DNS records created for instances"
  value = [
    for i in range(length(var.instance_ips)) : {
      name = cloudflare_record.dns_record[i].name
      ip   = cloudflare_record.dns_record[i].content
    }
  ]
}

