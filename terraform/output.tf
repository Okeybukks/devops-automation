output name {
  value       = aws_db_instance.my_rds_db.endpoint
  sensitive   = true
  description = "description"
  depends_on  = [aws_db_instance.my_rds_db.id]
}
