variable "stage" {
  type = string
}

variable "aws_region" {
  type = string
}

variable "aws_availability_zone" {
  type = string
}

variable "aws_number_server_nodes" {
  type = number
}

variable "aws_number_worker_nodes" {
  type = number
}

variable "aws_instance_type_server_nodes" {
  type = string
}

variable "aws_instance_type_worker_nodes" {
  type = string
}

variable "ssh_public_keys" {
  type = list(string)
}

variable "aws_ami" {
  type = string
  default = "ami-0e597b908340825b5" # AMAZON Linux 2023 AMI (ARM64)
  description = "amazon image id for linux instances"
}

variable "expose_management_protocols" {
  type = bool
  description = "expose protocols like ssh and kubernetes api port"
}