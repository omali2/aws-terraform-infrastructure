## Subnet
resource "aws_subnet" "database" {

  count              = length(var.subnet_cidr)
  cidr_block         = element(var.subnet_cidr,count.index)
  vpc_id             = var.vpc_id

  tags = {
      Name = "${var.name}-${count.index}"
  }
}

resource "aws_route_table_association" "database" {
  count          = length(var.subnet_cidr)

  subnet_id      = element(aws_subnet.database.*.id, count.index)
  route_table_id = var.route_id
}
