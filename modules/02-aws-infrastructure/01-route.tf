#internet gateway

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main_vpc.id
  tags = {
    Name = "${var.stage}-igw"
  }
}

# route table for pvc
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
   tags = {
    Name = "${var.stage}-public-rt"
  }
}

#associate route table with subnet
resource "aws_route_table_association" "public_assoc" {
  subnet_id = aws_subnet.main_subnet.id
  route_table_id = aws_route_table.public.id
}
