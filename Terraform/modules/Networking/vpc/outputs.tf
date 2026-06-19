
output "id" {
  description = "Id VPC"
  value = aws_vpc.this.id
}

output "vpc" {
  description = "All outputs"
  value = aws_vpc.this
}