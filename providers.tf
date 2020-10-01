variable "hcloud_token" {}
variable "hetzner_dns_token" {}
variable "dns_zone" {}
variable "record_name"  {}
variable "ssh_key"  {}

provider "hcloud"   {
    token = var.hcloud_token
}

provider "rancher2" {
  alias = "bootstrap"
  api_url = format("https://%s", hcloud_server.k8s-master.ipv4_address)
  bootstrap = true
  insecure = true
}

resource "rancher2_bootstrap" "admin" { 
  provider = rancher2.bootstrap
  telemetry = true
}

provider "rancher2" {
  alias = "admin"
  api_url = rancher2_bootstrap.admin.url
  token_key = rancher2_bootstrap.admin.token
  insecure = true
}

provider "hetznerdns" {
  apitoken = var.hetzner_dns_token
}

data "hcloud_location" "nurmberg" { 
    name = "nbg1"
}

resource "hcloud_ssh_key" "default" {
  name = "Rancher-Host SSH Key"
  public_key = var.ssh_key
}
