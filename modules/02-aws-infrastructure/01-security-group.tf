# k3s internal vpc traffic

resource "aws_security_group" "k3s_internal" {
  name = "${var.stage}-k3s-internal"
  description = "internal tcp and udp traffic within vpc"
  vpc_id = aws_vpc.main_vpc.id

  ingress {
    from_port = 0
    to_port = 65535
    protocol = "tcp"
    cidr_blocks = [aws_vpc.main_vpc.cidr_block]
  }
  ingress {
    from_port = 0
    to_port = 65535
    protocol = "udp"
    cidr_blocks = [aws_vpc.main_vpc.cidr_block]
  }
  egress {
    from_port = 0
    to_port = 65535
    protocol = "tcp"
    cidr_blocks = [aws_vpc.main_vpc.cidr_block]
  }
  egress {
    from_port = 0
    to_port = 65535
    protocol = "udp"
    cidr_blocks = [aws_vpc.main_vpc.cidr_block]
  }

  tags = {
    Name = "${var.stage}-k3s-internal"
  }

}

# k3s ingress
resource "aws_security_group" "k3s_ingress" {
  name = "${var.stage}-k3s-ingress"
  description = "inbound traffic allowed to k3s nodes "
  vpc_id = aws_vpc.main_vpc.id

  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
 
  tags = {
    Name = "${var.stage}-k3s-ingress"
  }
}


# k3s egress
resource "aws_security_group" "k3s_egress" {
  name = "${var.stage}-k3s-egress"
  description = "outbound traffic allowed from k3s nodes"
  vpc_id = aws_vpc.main_vpc.id

  egress {
    from_port = 0
    to_port = 65535
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
 
  tags = {
    Name = "${var.stage}-k3s-egress"
  }
}

# management ingress (ssh + api)
resource "aws_security_group" "management_ingress" {
  name = "${var.stage}-k3s-management-ingress"
  description = "inbound traffic allowed for SSH and Kubernetes API Port"
  vpc_id = aws_vpc.main_vpc.id

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  
  ingress {
    from_port = 6443
    to_port = 6443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
 
  tags = {
    Name = "${var.stage}-k3s-management-ingress"
  }
}