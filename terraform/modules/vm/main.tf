resource "proxmox_virtual_environment_vm" "vm" {
  name      = var.name
  node_name = "pve"
  vm_id     = var.vm_id

  clone {
    vm_id = 9000
    full  = true
  }

  cpu { cores = var.cores }
  memory { 
    dedicated = var.memory
    floating = var.memory / 2
  }

  disk {
    datastore_id = "vms"
    interface    = "scsi0"
    size         = var.disk_size
  }

  initialization {
    user_data_file_id = proxmox_virtual_environment_file.cloud_init_user_data.id

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

resource "proxmox_virtual_environment_file" "cloud_init_user_data" {
  content_type = "snippets"
  datastore_id = "local" # Must be a storage that has 'snippets' enabled in PVE
  node_name    = "pve"

  source_raw {
    data = <<-EOF
      #cloud-config
      hostname: ${var.name}
      fqdn: ${var.name}.homelab.local
      package_update: true
      package_upgrade: false
      packages:
        - python3
        - python3-pip
        - python3-venv
      users:
        - default
        - name: ${var.username}
          gecos: ${var.username}
          groups: sudo
          shell: /bin/bash
          sudo: ALL=(ALL) NOPASSWD:ALL
          ssh_authorized_keys:
            - ${var.ssh_key}
    EOF

    file_name = "user-data-${var.name}.yaml"
  }
}