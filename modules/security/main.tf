# Public SG
resource "aws_security_group" "public_sg" {
  name   = "${var.env_tag}-public-sg"
  vpc_id = var.vpc_id
  description = "Public SG - allow SSH from my IP and HTTP"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.my_ip]
    description = "SSH from my IP"
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "HTTP"
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "${var.env_tag}-public-sg" }
}

# Private SG
resource "aws_security_group" "private_sg" {
  name   = "${var.env_tag}-private-sg"
  vpc_id = var.vpc_id
  description = "Private SG - allow SSH from public SG only"

  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.public_sg.id]
    description = "SSH from public SG"
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "${var.env_tag}-private-sg" }
}


