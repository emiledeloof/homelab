module "dns_server" {
  source = "./modules/vm"

  name       = "dns"
  vm_id      = 101
  cores      = 2
  memory     = 1024
  disk_size  = 10
  ip_address = "192.168.1.101/24"
  ssh_key    = var.ssh_key
}