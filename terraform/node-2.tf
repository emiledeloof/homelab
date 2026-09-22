module "node-2" {
  source = "./modules/vm"

  name       = "K3S-node-2"
  vm_id      = 105
  cores      = 2
  memory     = 2048
  disk_size  = 20
  ip_address = "192.168.1.105/24"
  ssh_key    = var.ssh_key
}