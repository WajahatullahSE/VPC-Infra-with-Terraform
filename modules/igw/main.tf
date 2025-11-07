resource "aws_internet_gateway" "this" {
  vpc_id = var.vpc_id
  tags = {
    Name = "${var.env_tag}-igw"
    Environment = var.env_tag
  }
}

