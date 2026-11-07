resource "proxmox_download_file" "debian_cloud_img" {
  content_type = "import"
  datastore_id = "local"
  node_name    = "pve"
  url          = "https://cloud.debian.org/images/cloud/trixie/latest/debian-13-generic-amd64.qcow2"
}

resource "proxmox_download_file" "homeassistant_cloud_img" {
  content_type = "import"
  datastore_id = "local"
  node_name    = "pve"
  url          = "https://github.com/home-assistant/operating-system/releases/download/18.4/haos_ova-18.4.qcow2.xz"
}
