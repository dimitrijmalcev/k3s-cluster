locals {
    stage = "dev"
    route53_zone_name = "<your route53 zone>"
}

inputs = {
    stage = local.stage

    #infrastructure configuration
    expose_management_protocols = true
    cloud_infrastructure_provider = "aws"
    ssh_public_keys = [
        "<your ssh public key here>"
    ]

    #for hetzner cloud configuration
    hetzner_api_token = run_cmd("aws", "ssm", "get-parameter", "--name", "hetzner_token", "--with-decryption", "--query", "Parameter.Value", "--output", "text")
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
}