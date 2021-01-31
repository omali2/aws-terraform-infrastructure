variable "amis" {
    description = "AMIs by region"
    default = {
        eu-central-1 = "ami-f1810f86" # ubuntu 14.04 LTS
    }
}

variable "vpc_id" {
  description = "vpc id"
  type        = string
}

variable "name" {
  description = "Name to be used on all the resources as identifier"
  type        = string
}

variable "subnet_cidr" {
  description = "A list of public subnets inside the VPC"
  type        = list(string)
  default     = []
}
