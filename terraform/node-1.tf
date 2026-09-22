module "node-1" {
  source = "./modules/vm"

  name       = "K3S-node-1"
  vm_id      = 104
  cores      = 2
  memory     = 2048
  disk_size  = 20
  ip_address = "192.168.1.104/24"
  ssh_key    = var.ssh_key
}