################
# Publiс routes
################
resource "aws_route_table" "main" {
  #count = var.create_vpc && length(var.subnet_cidr) > 0 ? 1 : 0

  vpc_id             = var.vpc_id

  tags = merge(
    {
      "Name" = format("%s", var.name)
    },
    var.tags,
    var.private_route_table_tags,
  )
}

resource "aws_route_table_association" "a" {
  subnet_id         = var.subnet_id
  route_table_id    = var.route_id
}
