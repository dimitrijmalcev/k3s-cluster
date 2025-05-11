locals {
    stage = "dev"
    route53_zone_name = "<your route53 zone>"
}

inputs = {
    stage = local.stage

    #infrastructure configuration
    expose_management_protocols = true
    cloud_infrastructure_provider = "onprem-simple"
    ssh_public_keys = [
        "<your ssh public key here>"
    ]

    #for hetzner cloud configuration
    hetzner_api_token = run_cmd("--terragrunt-quiet","aws", "ssm", "get-parameter", "--name", "hetzner_token", "--with-decryption", "--query", "Parameter.Value", "--output", "text")
    hcloud_number_server_nodes = 1
    hcloud_number_worker_nodes = 1
    hcloud_type_worker_nodes="cax11"
    hcloud_type_server_nodes="cax11"
    hcloud_dc1="nbg1-dc3" # datacenter Nuremberg, Germany
    hcloud_dc2="fsn1-dc14" # datacenter Falkenstein, Germany
    hcloud_zone="eu-central"

    #for aws cloud configuration
    aws_instance_type_worker_nodes = "t4g.nano"
    aws_instance_type_server_nodes = "t4g.small"
    aws_number_server_nodes = 1
    aws_number_worker_nodes = 1
    aws_region = "eu-central-1"
    aws_availability_zone = "eu-central-1a"
    aws_ami = "ami-0e597b908340825b5" # AMAZON Linux 2023 AMI (ARM64)

    proxmox_api_url = "https://192.168.0.201:8006/api2/json"
    proxmox_api_user = run_cmd("--terragrunt-quiet","aws", "ssm", "get-parameter", "--name", "/proxmox/test/user", "--with-decryption", "--query", "Parameter.Value", "--output", "text")
    proxmox_api_password = run_cmd("--terragrunt-quiet","aws", "ssm", "get-parameter", "--name", "/proxmox/test/password", "--with-decryption", "--query", "Parameter.Value", "--output", "text")
    proxmox_vms = [
        {
            image_id = "local:iso/rocky.img"
            proxmox_node = "pve1"
            vm_name = "k3s-server-1"
            ip_address = "192.168.0.160"
            gateway = "192.168.0.1"
            memory = 3072
            cpu = 2
        },
        {
            image_id = "local:iso/rocky.img"
            proxmox_node = "pve2"
            vm_name = "k3s-worker-1"
            ip_address = "192.168.0.161"
            gateway = "192.168.0.1"
            memory = 3072
            cpu = 2
        },
        {
            image_id = "local:iso/rocky.img"
            proxmox_node = "pve3"
            vm_name = "k3s-worker-2"
            ip_address = "192.168.0.162"
            gateway = "192.168.0.1"
            memory = 3072
            cpu = 2
        }
    ]

    # for onprem infrastructure already existing
    onprem_server_ips = ["192.168.0.160"]
    onprem_worker_ips = ["192.168.0.161","192.168.0.162"]
    onprem_user = "root"
}