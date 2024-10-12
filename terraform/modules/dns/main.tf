resource "cloudflare_record" "dns_record" {
  count   = length(var.instance_ips)
  zone_id = var.zone_id
  name    = element(var.instance_names, count.index)
  content = element(var.instance_ips, count.index)
  type    = "A"
  ttl     = 1
  proxied = true
}

