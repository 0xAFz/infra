module "nova" {
  source         = "./modules"
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

