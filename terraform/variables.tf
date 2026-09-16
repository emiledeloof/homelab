variable "pve_api_token" {
  type      = string
  sensitive = true # Prevents OpenTofu from printing it in plan/apply terminal outputs
}

variable "pve_endpoint" {
  type = string
}

variable "tofu_encryption_passphrase" {
  type      = string
  sensitive = true
}