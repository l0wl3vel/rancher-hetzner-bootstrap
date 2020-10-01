output "master_ip"    {
    value = hcloud_server.k8s-master.ipv4_address
}

output "admin_password"    {
    value = rancher2_bootstrap.admin.current_password
}
