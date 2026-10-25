resource "proxmox_virtual_environment_download_file" "debian_cloud_img" {
  content_type = "import"
  datastore_id = "local"
  node_name    = "pve-01"
  url          = "https://cloud.debian.org/images/cloud/trixie/latest/debian-13-generic-amd64.qcow2"
}
