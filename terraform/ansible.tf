module "ansible" {
  source = "./modules/vm"

  name       = "ansible"
  vm_id      = 102
  cores      = 4
  memory     = 2048
  disk_size  = 20
  ip_address = "192.168.1.102/24"
  ssh_key    = var.ssh_key
}