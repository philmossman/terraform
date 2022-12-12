# show DHCP IP address on VM creation
output "dhcp_ip" {
  value = proxmox_vm_qemu.ubuntu-server.default_ipv4_address
}