module "home-assistant" {
  source = "./modules/vm"

  name       = "home-assistant"
  vm_id      = 107
  cores      = 2
  memory     = 4096
  disk_size  = 30
  ip_address = "192.168.1.107/24"
  ssh_key    = var.ssh_key
}
