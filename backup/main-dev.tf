# Terraform configuration

provider "aws" {
  region = var.vpc_region
}

module "VPC" {

    source  = "../modules/Netzwerk/vpc"

    create_vpc                       = var.create_vpc
    name                             = var.name
    cidr                             = var.cidr
    instance_tenancy                 = var.instance_tenancy
    enable_dns_hostnames             = var.enable_dns_hostnames
    enable_dns_support               = var.enable_dns_support
    enable_classiclink               = var.enable_classiclink
    enable_classiclink_dns_support   = var.enable_classiclink_dns_suppor
    enable_ipv6                      = var.enable_ipv6
    secondary_cidr_blocks            = var.secondary_cidr_blocks
    manage_default_security_group    = var.manage_default_security_group
    default_security_group_ingress   = var.default_security_group_ingress
    default_security_group_egress    = var.default_security_group_egress


    tags = merge(
      {
        "Name" = format("%s", var.name)
      },
      var.tags,
      var.vpc_tags,
    )
}

# END of VPC

##### S3
module "website_s3_bucket" {
  source = "../modules/Storage/s3"

  bucket_name = var.vpc_bucket_name

  tags = {
    Terraform   = "true"
    Environment = var.vpc_environment
  }
}

###### end of S3

#module "vpc" {
 # source  = "terraform-aws-modules/vpc/aws"
 # version = "2.21.0"

#  name = var.vpc_name
#  cidr = var.vpc_cidr

#  azs             = var.vpc_azs
#  private_subnets = var.vpc_private_subnets
#  public_subnets  = var.vpc_public_subnets

#  enable_nat_gateway = var.vpc_enable_nat_gateway

#  tags = var.vpc_tags
#}

#module "ec2_instances" {

  #source  = "terraform-aws-modules/ec2-instance/aws"
  #version = "2.12.0"

  #name           = "test-ec2-cluster"
  #instance_count = 1

  #ami                    = "ami-0c5204531f799e0c6"
  #instance_type          = "t2.micro"
  #vpc_security_group_ids = [module.vpc.default_security_group_id]
  #subnet_id              = module.vpc.public_subnets[0]

  #tags = {
   # Terraform   = "true"
   # Environment = var.vpc_environment
  #}
#}
