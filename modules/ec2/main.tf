data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = [var.ami_owner]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

# Public EC2 (bastion)
resource "aws_instance" "public" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_public_id
  key_name               = var.key_name
  vpc_security_group_ids = [var.public_sg_id]
  associate_public_ip_address = true
  tags = {
    Name = "${var.env_tag}-public-ec2"
  }
}

# Private EC2
resource "aws_instance" "private" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_private_id
  key_name               = var.key_name
  vpc_security_group_ids = [var.private_sg_id]
  associate_public_ip_address = false
  tags = {
    Name = "${var.env_tag}-priv-ec2"
  }
}



