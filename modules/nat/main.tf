resource "aws_eip" "nat_eip" {
  tags = {
    Name = "${var.env_tag}-nat-eip"
  }
}

resource "aws_nat_gateway" "this" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = var.public_subnet_id
  tags = {
    Name = "${var.env_tag}-natgw"
  }
}



