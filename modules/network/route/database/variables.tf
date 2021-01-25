variable "vpc_id" {
  description = "vpc id"
  type        = string
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "name" {
  description = "Name to be used on all the resources as identifier"
  type        = string
}

variable "database_route_table_tags" {
  description = "Additional tags for the public route tables"
  type        = map(string)
  default     = {}
}

variable "enable_ipv6" {
  description = "Requests an Amazon-provided IPv6 CIDR block with a /56 prefix length for the VPC. You cannot specify the range of IP addresses, or the size of the CIDR block."
  type        = bool
  default     = false
}

variable "subnet_associated_cidr" {
  description = "A list of public subnets inside the VPC"
  type        = list(string)
  default     = []
}
