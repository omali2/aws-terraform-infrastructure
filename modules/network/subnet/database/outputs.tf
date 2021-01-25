output "database_subnet_id" {
  description = "The ID of the subnet"
  value       = join("", aws_subnet.main[*].id)
}
