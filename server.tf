resource "hcloud_network" "k8s-net" {
  name = "k8s-net"
  ip_range = "10.42.0.0/16"
}

data "hcloud_image" "ubuntu_latest" { 
  most_recent = true
  name = "ubuntu-20.04"
}

resource "hcloud_server" "k8s-master" { 
  location = data.hcloud_location.nurmberg.name
  ssh_keys = [hcloud_ssh_key.default.id]
  server_type = "cx11"
  name = "k8s-master"
  image = data.hcloud_image.ubuntu_latest.name

  connection  {
    type = "ssh"
    user = "root"
    host = self.ipv4_address
  }

  provisioner "remote-exec" {
    inline = [
      "apt update",
      "apt -y dist-upgrade",
      "apt -y install docker.io",
      "systemctl start docker.service",
      "systemctl enable docker.service",
      "docker run -d --restart=unless-stopped -p 80:80 -p 443:443 -v /opt/rancher:/var/lib/rancher rancher/rancher:latest --acme-domain rancher.l0wl3vel.dev",
      "sleep 60"
    ]
  }

}

resource "hcloud_network_subnet" "subnet1" { 
  ip_range = "10.42.0.0/16"
  network_id = hcloud_network.k8s-net.id
  network_zone = "eu-central"
  type = "cloud"
}

resource "hcloud_server_network" "k8s-master" { 
  network_id = hcloud_network.k8s-net.id
  server_id = hcloud_server.k8s-master.id
}