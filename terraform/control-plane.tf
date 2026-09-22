module "control-plane" {
  source = "./modules/vm"

  name       = "K3S-control-plane"
  vm_id      = 102
  cores      = 2
  memory     = 4192
  disk_size  = 30
  ip_address = "192.168.1.102/24"
  ssh_key    = var.ssh_key
}