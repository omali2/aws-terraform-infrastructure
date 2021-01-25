## Subnet

resource "aws_subnet" "main" {

  count              = length(var.subnet_cidr)
  cidr_block         = element(var.subnet_cidr,count.index)
  vpc_id             = var.vpc_id

  tags = {
      Name = "${var.name}-${count.index}"
  }
}
