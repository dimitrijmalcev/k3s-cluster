resource "proxmox_virtual_environment_file" "user_data_cloud_config" {
    for_each = { for vm in var.proxmox_vms : vm.vm_name => vm}
    content_type = "snippets"
    datastore_id = "local"
    node_name = each.value.proxmox_node

    source_raw  {
        data = <<-EOF
        #cloud-config
        hostname: ${each.value.vm_name}
        timezone: Europe/Berlin
        users:
          - name: root
            groups:
             - sudo
            shell: /bin/bash
            ssh_authorized_keys:
%{ for key in var.ssh_public_keys ~}
            - ${key}
%{ endfor ~}
        package_update: true
        packages:
          - qemu-guest-agent
          - net-tools
          - curl
        runcmd:
          - echo "done" > /tmp/cloud-config.done
        EOF
        file_name = "${each.value.vm_name}-cloud-config.yaml"   
    }
     
}

resource "proxmox_virtual_environment_vm" "rocky_vm" {
    for_each = { for vm in var.proxmox_vms : vm.vm_name => vm}
    name = each.value.vm_name
    node_name = each.value.proxmox_node
    vm_id = 100 + index(var.proxmox_vms, each.value)

    cpu {
        cores = each.value.cpu
        type  = "x86-64-v2"
    }

    memory {
        dedicated = each.value.memory
        floating = each.value.memory
    }

    agent {
        enabled = true
    }

    stop_on_destroy = false

    initialization{
        user_data_file_id = proxmox_virtual_environment_file.user_data_cloud_config[each.key].id
        ip_config{
            ipv4{
                address = "${each.value.ip_address}/24"
                gateway = each.value.gateway
            }
        }       
    }

    network_device{
        bridge = "vmbr0"
    }
    
    scsi_hardware = "virtio-scsi-pci"

    serial_device{}

    disk {
        datastore_id = "local-lvm"
        file_id = each.value.image_id
        interface = "scsi0"
        discard = "on"
        size = 25
    }
}