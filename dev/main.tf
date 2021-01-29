# Terraform configuration
data "aws_availability_zones" "available" {}

######
# VPC
######
module "vpc" {
  source  = "../modules/network/vpc"

  vpc_region                       = var.vpc_region
  create_vpc                       = var.create_vpc
  name                             = var.name
  tags                             = var.tags
  vpc_tags                         = var.vpc_tags
  cidr                             = var.cidr
  instance_tenancy                 = var.instance_tenancy
  enable_dns_hostnames             = var.enable_dns_hostnames
  enable_dns_support               = var.enable_dns_support
  enable_classiclink               = var.enable_classiclink
  enable_classiclink_dns_support   = var.enable_classiclink_dns_support
  enable_ipv6                      = var.enable_ipv6

}
# END of VPC
# subnet
module "vpc_public_subnets" {
  source  = "../modules/network/subnet/public"

    vpc_id            = module.vpc.vpc_id
    route_id          = module.aws_public_route_table.public_route_table_id
    subnet_cidr       = var.public_subnet_cidr
    vpc_region        = var.vpc_region
    tags              = var.tags
    name              = "${var.vpc_environment}_public_subnets"
}

module "vpc_private_subnets" {
  source  = "../modules/network/subnet/private"

    vpc_id            = module.vpc.vpc_id
    route_id          = module.aws_private_route_table.private_route_table_id
    subnet_cidr       = var.private_subnet_cidr
    vpc_region        = var.vpc_region
    tags              = var.tags
    name              = "${var.vpc_environment}_private_subnets"
}

module "vpc_database_subnets" {
  source  = "../modules/network/subnet/database"

    vpc_id            = module.vpc.vpc_id
    route_id          = module.aws_database_route_table.database_route_table_id
    subnet_cidr       = var.database_subnet_cidr
    vpc_region        = var.vpc_region
    tags              = var.tags
    name              = "${var.vpc_environment}_database_subnets"
}

# Internet Gateway
###################
module "aws_internet_gateway" {
  source  = "../modules/network/igw"

  vpc_id            = module.vpc.vpc_id
  create_vpc        = var.create_vpc
  create_igw        = var.create_igw
  subnet_cidr       = var.public_subnet_cidr
  tags              = var.tags
  name              = "${var.name}_${var.vpc_environment}_igw"

}

###################
# DHCP Options Set
###################
module "aws_vpc_dhcp_options" {
  source  = "../modules/network/dhcp"

  vpc_id                            = module.vpc.vpc_id
  create_vpc                        = var.create_vpc
  enable_dhcp_options               = var.enable_dhcp_options
  dhcp_options_domain_name          = var.dhcp_options_domain_name
  dhcp_options_domain_name_servers  = var.dhcp_options_domain_name_servers
  dhcp_options_ntp_servers          = var.dhcp_options_ntp_servers
  dhcp_options_netbios_name_servers = var.dhcp_options_netbios_name_servers
  dhcp_options_netbios_node_type    = var.dhcp_options_netbios_node_type
  tags                              = var.tags
  dhcp_options_tags                 = var.dhcp_options_tags
  name                              = "${var.name}_${var.vpc_environment}_dhcp"

}

################
# Publiс routes
################
module "aws_public_route_table" {
  source  = "../modules/network/route/public"

  vpc_id                            = module.vpc.vpc_id
  name                              = "${var.name}_${var.vpc_environment}_${var.public_subnet_suffix}"
  tags                              = var.tags
  public_route_table_tags           = var.public_route_table_tags
  enable_ipv6                       = var.enable_ipv6
}

###############
# Publiс routes
################
module "aws_private_route_table" {
  source  = "../modules/network/route/private"

  vpc_id                            = module.vpc.vpc_id
  name                              = "${var.name}_${var.vpc_environment}_${var.private_subnet_suffix}"
  tags                              = var.tags
  private_route_table_tags          = var.private_route_table_tags
  subnet_associated_cidr            = var.private_subnet_cidr
  enable_ipv6                       = var.enable_ipv6
}

###############
# Database routes
################
module "aws_database_route_table" {
  source  = "../modules/network/route/database"

  vpc_id                            = module.vpc.vpc_id
  name                              = "${var.name}_${var.vpc_environment}_${var.database_subnet_suffix}"
  tags                              = var.tags
  database_route_table_tags          = var.database_route_table_tags
  subnet_associated_cidr            = var.database_subnet_cidr
  enable_ipv6                       = var.enable_ipv6
}

###############
# routes to Internet GW
################
module "route_internet_gateway" {
  source  = "../modules/network/route/igw_route"
  #count = var.create_vpc && var.create_igw && length(var.subnet_cidr) > 0 ? 1 : 0

  igw_id       = module.aws_internet_gateway.igw_route_id
  route_id     = module.aws_public_route_table.public_route_table_id

}

#######
# Security group
#######
module "aws_default_security_group" {
  source  = "../modules/network/sg/default"

  vpc_id       = module.vpc.vpc_id
  subnet_cidr  = var.default_subnet_cidr
  name         = "${var.name}_${var.vpc_environment}_default_sq"

}

module "aws_public_security_group" {
  source  = "../modules/network/sg/public"

  vpc_id       = module.vpc.vpc_id
  subnet_cidr  = var.public_subnet_cidr
  name         = "${var.name}_${var.vpc_environment}_public_sq"

}

module "aws_private_security_group" {
  source  = "../modules/network/sg/private"

  vpc_id       = module.vpc.vpc_id
  subnet_cidr  = var.private_subnet_cidr
  name         = "${var.name}_${var.vpc_environment}_private_sq"

}

module "aws_database_security_group" {
  source  = "../modules/network/sg/database"

  vpc_id       = module.vpc.vpc_id
  subnet_cidr  = var.database_subnet_cidr
  name         = "${var.name}_${var.vpc_environment}_database_sq"

}
