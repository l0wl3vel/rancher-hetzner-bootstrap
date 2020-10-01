resource "rancher2_node_driver" "hcloud" { 
  provider = rancher2.admin
  active = true
  builtin = false
  name = "hetzner"
  url = "https://github.com/JonasProgrammer/docker-machine-driver-hetzner/releases/download/2.1.0/docker-machine-driver-hetzner_2.1.0_linux_amd64.tar.gz"
  ui_url = "https://storage.googleapis.com/hcloud-rancher-v2-ui-driver/component.js"
  whitelist_domains = ["storage.googleapis.com"]
}