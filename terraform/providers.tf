provider "proxmox" {
  endpoint  = var.pve_endpoint
  api_token = var.pve_api_token
  insecure  = true

  ssh {
    agent    = false
    username = "root"
    private_key = file("~/.ssh/homelab")
  }
}
