module "caddy" {
  source = "./modules/vm"

  name       = "caddy-reverse-proxy"
  vm_id      = 106
  cores      = 1
  memory     = 512
  disk_size  = 5
  ip_address = "192.168.1.106/24"
  ssh_key    = var.ssh_key
}