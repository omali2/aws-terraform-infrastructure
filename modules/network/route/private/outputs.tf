output "private_route_table_id" {
  description = "The ID of the Route table"
  value       = aws_route_table.private.id
  # value = join("", aws_route_table.private[*].id)
}
