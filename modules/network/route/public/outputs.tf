output "public_route_table_id" {
  description = "The ID of the Route table"
  value       = aws_route_table.public.id
  # value = join("", aws_route_table.public[*].id)
}
