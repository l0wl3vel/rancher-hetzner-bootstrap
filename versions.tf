terraform {
  required_providers {
    hcloud = {
      source = "terraform-providers/hcloud"
    }
    rancher2 = {
      source = "terraform-providers/rancher2"
    }
    hetznerdns = {
      source = "timohirt/hetznerdns"
      version = "1.1.1"
    }
  }
  required_version = ">= 0.13"
}