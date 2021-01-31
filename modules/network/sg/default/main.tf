resource "aws_default_security_group" "default" {

  vpc_id      = var.vpc_id

  ingress {
    description = "any from VPC"
    self      = true
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    #cidr_blocks = var.subnet_cidr
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.subnet_cidr
  }

  tags = {
    Name = "default_sg"
  }
}
