module "vm" {
  source = "./modules/vm"

  os_auth_url    = var.os_auth_url
  os_username    = var.os_username
  os_password    = var.os_password
  os_tenant_name = var.os_tenant_name
  os_region      = var.os_region
  instance_name  = var.instance_name
  flavor_name    = var.flavor_name
  image_name     = var.image_name
  network_name   = var.network_name
  keypair_name   = var.keypair_name
  pubkey_path    = var.pubkey_path
  instance_count = var.instance_count
}

module "dns" {
  source = "./modules/dns"

  count                = var.use_dns ? 1 : 0
  domain               = var.cloudflare_domain
  account_id           = var.cloudflare_account_id
  cloudflare_api_token = var.cloudflare_api_token
  zone_id              = var.cloudflare_zone_id

  instance_ips   = module.vm.instance_public_ips
  instance_names = module.vm.instance_names

  providers = {
    cloudflare = cloudflare
  }
}

