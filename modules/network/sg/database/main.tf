resource "aws_security_group" "database" {

  name        = var.name
  description = "Allow TLS inbound traffic"
  vpc_id      = var.vpc_id

  ingress { # SQL Server
      from_port = 1433
      to_port = 1433
      protocol = "tcp"
      cidr_blocks = var.subnet_cidr
      #security_groups = ["${aws_security_group.web.id}"]
  }
  ingress { # MySQL
      from_port = 3306
      to_port = 3306
      protocol = "tcp"
      cidr_blocks = var.subnet_cidr
      #security_groups = ["${aws_security_group.web.id}"]
  }

  ingress {
      from_port = 22
      to_port = 22
      protocol = "tcp"
      cidr_blocks = var.subnet_cidr
  }
  
  ingress {
      from_port = -1
      to_port = -1
      protocol = "icmp"
      cidr_blocks = var.subnet_cidr
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.name
  }
}
