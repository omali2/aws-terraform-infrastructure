variable "vpc_id" {
  description = "vpc id"
  type        = string
}

variable "vpc_region" {
  description = "region"
  type        = string
  default     = "eu-central-1"
}


variable "subnet_cidr" {
  description = "A list of public subnets inside the VPC"
  type        = list(string)
  default     = []
}

variable "name" {
  description = "Name to be used on all the resources as identifier"
  type        = string
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "route_id" {
  description = "route id"
  type        = string
}
