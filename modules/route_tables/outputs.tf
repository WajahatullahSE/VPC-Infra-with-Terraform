#for the vpc endpoints (s3)
output "private_route_table_ids" {
  value = [aws_route_table.private_rt.id]
}