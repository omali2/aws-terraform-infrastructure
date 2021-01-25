# Input variable definitions

variable "vpc_environment" {
  description = "VPC Stage environment"
  type        = string
  default     = "prod"
}

variable "create_vpc" {
  description = "Controls if VPC should be created (it affects almost all resources)"
  type        = bool
  default     = true
}

variable "create_ec2" {
  description = "Controls if VPC should be created (it affects almost all resources)"
  type        = bool
  default     = true
}

variable "vpc_name" {
  description = "Name of VPC"
  type        = string
  default     = "prod-vpc"
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.2.0.0/16"
}

variable "vpc_region" {
  description = "region"
  type        = string
  default     = "eu-central-1"
}

variable "vpc_azs" {
  description = "Availability zones for VPC"
  type        = list
  default     = ["eu-central-1a", "eu-central-1b", "eu-central-1c"]
}

variable "vpc_private_subnets" {
  description = "Private subnets for VPC"
  type        = list(string)
  default     = ["10.2.1.0/24", "10.2.2.0/24"]
}

variable "vpc_public_subnets" {
  description = "Public subnets for VPC"
  type        = list(string)
  default     = ["10.2.101.0/24", "10.2.102.0/24"]
}

variable "vpc_enable_nat_gateway" {
  description = "Enable NAT gateway for VPC"
  type    = bool
  default = false
}

variable "vpc_tags" {
  description = "Tags to apply to resources created by VPC module"
  type        = map(string)
  default     = {
    Terraform   = "true"
    Environment = "prod"
  }
}

variable "ec2_instance_name" {
  description = "ec2 name"
  type        = string
  default     = "prod-ec2-cluster"
}

variable "ec2_instance_count" {
  description = "ec2 count"
  type        = string
  default     = "1"
}

variable "ec2_instance_ami" {
  description = "ec2 ami"
  type        = string
  default     = "ami-0c5204531f799e0c6"
}

variable "ec2_instance_type" {
  description = "ec2 type"
  type        = string
  default     = "t2.micro"
}

variable "vpc_bucket_name" {
  description = "S3 Bucket to save tfstate"
  type        = string
  default     = "prod-s3-bucket-tfstat"
}
