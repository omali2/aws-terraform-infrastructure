resource "aws_security_group" "default" {

  name        = var.name
  description = "Allow all inbound traffic"
  vpc_id      = var.vpc_id

  ingress {
    description = "ssh from VPC"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.subnet_cidr
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.subnet_cidr
  }

  tags = {
    Name = var.name
  }
}
