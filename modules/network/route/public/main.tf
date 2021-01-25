################
# Publiс routes
################
resource "aws_route_table" "public" {
  #count = var.create_vpc && length(var.subnet_cidr) > 0 ? 1 : 0

  vpc_id             = var.vpc_id

  tags = merge(
    {
      "Name" = format("%s", var.name)
    },
    var.tags,
    var.public_route_table_tags,
  )
}
