resource "proxmox_virtual_environment_vm" "vm" {
  name          = var.name
  node_name     = "pve"
  vm_id         = var.vm_id
  scsi_hardware = "virtio-scsi-single"
  boot_order    = ["scsi0"] # Forces immediate boot from the imported disk

  agent {
    enabled = true
    timeout = "5m" # 1m is too short when installing python3-pip + dependencies
  }

  cpu {
    cores = var.cores
    type  = "x86-64-v2-AES"
  }

  memory {
    dedicated = var.memory
    floating  = var.memory / 2
  }

  # Enables Proxmox xterm.js console so you can watch Cloud-Init run live
  serial_device {}
  vga {
    type = "serial0"
  }

  disk {
    datastore_id = "vms"
    interface    = "scsi0"
    iothread     = true
    discard      = "on"
    size         = var.disk_size
    import_from  = var.image_id
  }

  network_device {
    bridge = "vmbr0"
    model  = "virtio"
  }

  initialization {
    user_data_file_id = proxmox_virtual_environment_file.cloud_init_user_data.id
    datastore_id      = "vms"

    dns {
      servers = ["192.168.1.101", "1.1.1.1", "8.8.8.8"]
    }

    ip_config {
      ipv4 {
        address = var.ip_address # Must include CIDR, e.g. "192.168.1.50/24"
        gateway = var.gateway
      }
    }
  }
}

resource "proxmox_virtual_environment_file" "cloud_init_user_data" {
  content_type = "snippets"
  datastore_id = "local"
  node_name    = "pve"

  source_raw {
    # Using format + yamlencode prevents any invisible indentation/space bugs
    data = format("#cloud-config\n%s", yamlencode({
      hostname        = var.name
      fqdn            = "${var.name}.homelab.local"
      package_update  = true
      package_upgrade = false
      packages = [
        "qemu-guest-agent",
        "python3",
        "python3-pip",
        "python3-venv",
        "net-tools",
      ]
      users = [
        "default",
        {
          name                = var.username
          gecos               = var.username
          groups              = "sudo"
          shell               = "/bin/bash"
          sudo                = "ALL=(ALL) NOPASSWD:ALL"
          ssh_authorized_keys = [var.ssh_key]
        }
      ]
      runcmd = [
        ["systemctl", "enable", "--now", "qemu-guest-agent"]
      ]
    }))

    file_name = "user-data-${var.name}.yaml"
  }
}

resource "proxmox_download_file" "debian_cloud_img" {
  content_type = "import"
  datastore_id = "local"
  node_name    = "pve"
  url          = "https://cloud.debian.org/images/cloud/trixie/latest/debian-13-generic-amd64.qcow2"
}
