terraform {
  required_providers {
    proxmox = {
      source = "bpg/proxmox"
      version = "0.113.1"
    }
  }
}

terraform {
  encryption {
    key_provider "pbkdf2" "passphrase" {
      passphrase = var.tofu_encryption_passphrase
    }

    method "aes_gcm" "method" {
      keys = key_provider.pbkdf2.passphrase
    }

    state {
      method = method.aes_gcm.method
    }
  }
}