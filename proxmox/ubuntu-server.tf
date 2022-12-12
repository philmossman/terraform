# Proxmox Full-Clone
# ---
# Create a new Ubuntu Server from a packer clone

resource "proxmox_vm_qemu" "ubuntu-server" {

  # VM General Settings
  target_node = "pve"
  vmid        = "200"
  name        = "ubuntu-server"
  desc        = "Ubuntu Server from packer generated clone"

  # VM Advanced General Settings
  onboot = true

  # VM OS Settings
  clone = "ubuntu-server-jammy"

  # VM System Settings
  agent = 1

  # VM CPU Settings
  cores   = 2
  sockets = 1
  cpu     = "host"

  # VM Memory Settings
  memory = 4096

  # VM Network Settings
  network {
    bridge = "vmbr0"
    model  = "virtio"
    tag = "23"
  }

  # VM Cloud-Init Settings
  os_type = "cloud-init"

  # (Optional) IP Address and Gateway
  # ipconfig0 = "ip=0.0.0.0/0,gw=0.0.0.0"

  # (Optional) Default User
  ciuser = "phil"

  # (Optional) Add your SSH KEY
  sshkeys = <<EOF
  ${var.ssh_pub_key}
  EOF

  provisioner "remote-exec" {
    inline = [
      "systemctl start qemu-guest-agent"
    ]
  }
}