module "dns_server" {
  source = "./modules/vm"

  name       = "dns"
  vm_id      = 101
  cores      = 1
  memory     = 512
  disk_size  = 10
  ip_address = "192.168.1.101/24"
  ssh_key    = var.ssh_key
}