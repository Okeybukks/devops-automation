output vpc_id {
  value       = aws_vpc.altschool-capstone.id
  sensitive   = true
  description = "description"
  depends_on  = [aws_vpc.altschool-capstone]
}
