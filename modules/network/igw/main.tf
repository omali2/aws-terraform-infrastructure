###################
# Internet Gateway
###################
resource "aws_internet_gateway" "main" {
  #count = var.create_vpc && var.create_igw && length(var.subnet_cidr) > 0 ? 1 : 0

  vpc_id = var.vpc_id

  tags = merge(
    {
      "Name" = format("%s", var.name)
    },
    var.tags,
    var.igw_tags,
  )
}
