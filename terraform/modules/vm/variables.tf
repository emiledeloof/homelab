variable "name" {
  type = string
}

variable "vm_id" {
  type = number
}

variable "cores" {
  type    = number
  default = 2
}

variable "memory" {
  type    = number
  default = 2048
}

variable "disk_size" {
  type    = number
  default = 20
}

variable "ip_address" {
  type = string
}

variable "gateway" {
  type    = string
  default = "192.168.1.1"
}

variable "ssh_key" {
  type      = string
  sensitive = true
}

variable "username" {
  type    = string
  default = "homelab" # Fallback if not specified
}