resource "aws_vpc" "main_vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true

  tags ={
    Name = "${var.stage}-vpc"
    Stage = var.stage
  }
}

resource "aws_subnet" "main_subnet" {
  vpc_id = aws_vpc.main_vpc.id
  cidr_block =  "10.0.1.0/24"
  availability_zone = var.aws_availability_zone
  map_public_ip_on_launch = false

  tags ={
    Name = "${var.stage}-subnet-1"
    Stage = var.stage
  }
}

