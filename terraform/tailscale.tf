module "tailscale" {
  source = "./modules/vm"

  name       = "tailscale"
  vm_id      = 103
  cores      = 1
  memory     = 512
  disk_size  = 10
  ip_address = "192.168.1.103/24"
  ssh_key    = var.ssh_key
}