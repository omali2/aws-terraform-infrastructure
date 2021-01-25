################
# Publiс routes Internet GW
################
resource "aws_route" "public_internet_gateway" {
  #count = var.create_vpc && var.create_igw && length(var.subnet_cidr) > 0 ? 1 : 0

  route_table_id         = var.route_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = var.igw_id

  timeouts {
    create = "5m"
  }
}
