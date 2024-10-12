variable "cloudflare_api_token" {
  description = "Cloudflare api token"
  type        = string
}

variable "domain" {
  description = "Cloudflare domain"
  type        = string
}

variable "account_id" {
  description = "Cloudflare account id"
  type        = string
}

variable "zone_id" {
  description = "Cloudflare zone id"
  type        = string
}

variable "instance_ips" {
  description = "The public IPs of all instances"
  type        = list(string)
}

variable "instance_names" {
  description = "The name of all instances"
  type        = list(string)
}

