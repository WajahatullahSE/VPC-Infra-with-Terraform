resource "aws_subnet" "public" {
  for_each = { for idx, cidr in var.public_subnets : idx => cidr }
  vpc_id     = var.vpc_id
  cidr_block = each.value
  availability_zone = var.azs[tonumber(each.key)]
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.env_tag}-public-${each.key}"
    Environment = var.env_tag
  }
}

resource "aws_subnet" "private" {
  for_each = { for idx, cidr in var.private_subnets : idx => cidr }
  vpc_id     = var.vpc_id
  cidr_block = each.value
  availability_zone = var.azs[tonumber(each.key)]
  map_public_ip_on_launch = false
  tags = {
    Name = "${var.env_tag}-private-${each.key}"
    Environment = var.env_tag
  }
}


