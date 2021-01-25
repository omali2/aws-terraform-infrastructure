output "igw_route_id" {
  description = "The ID of the Internet Gateway"
  value       = aws_internet_gateway.main.id
}
