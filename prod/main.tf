# Terraform configuration

provider "aws" {
  region = var.vpc_region
}

module "vpc" {
  #count = var.create_vpc ? 1 : 0

  source  = "terraform-aws-modules/vpc/aws"
  version = "2.21.0"

  name = var.vpc_name
  cidr = var.vpc_cidr

  azs             = var.vpc_azs
  private_subnets = var.vpc_private_subnets
  public_subnets  = var.vpc_public_subnets

  enable_nat_gateway = var.vpc_enable_nat_gateway

  tags = var.vpc_tags
}

module "ec2_instances" {
  #count = var.create_ec2 ? 1 : 0

  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "2.12.0"

  name           = var.ec2_instance_name
  instance_count = var.ec2_instance_count

  ami                    = var.ec2_instance_ami
  instance_type          = var.ec2_instance_type
  vpc_security_group_ids = [module.vpc.default_security_group_id]
  subnet_id              = module.vpc.public_subnets[0]

  tags = {
    Terraform   = "true"
    Environment = var.vpc_environment
  }
}

module "website_s3_bucket" {
  source = "../modules/Storage/s3"

  bucket_name = var.vpc_bucket_name

  tags = {
    Terraform   = "true"
    Environment = var.vpc_environment
  }
}
