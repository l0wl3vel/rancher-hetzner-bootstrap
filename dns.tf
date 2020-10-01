data "hetznerdns_zone" "dns_zone" {
    name = var.dns_zone
}

resource "hetznerdns_record" "rancher-master" {
    zone_id = data.hetznerdns_zone.dns_zone.id
    name = var.record_name
    value = hcloud_server.k8s-master.ipv4_address
    type = "A"
    ttl= 3600
}