resource "proxmox_virtual_environment_vm" "vm" {
  name      = var.name
  node_name = "pve"
  vm_id     = var.vm_id

  clone {
    vm_id = 9000
    full  = true
  }

  cpu { cores = var.cores }
  memory { dedicated = var.memory }

  disk {
    datastore_id = "vms"
    interface    = "scsi0"
    size         = var.disk_size
  }

  initialization {
    ip_config {
      ipv4 {
        address = var.ip_address
        gateway = var.gateway
      }
    }
    user_account {
      username = var.username
      keys     = [var.ssh_key]
    }
  }

  agent { enabled = true }
}