
output "arn" {
  description = "Internet gateway arn"
  value       = aws_internet_gateway.gw.arn
}

output "id" {
  description = "Internet gateway id"
  value       = aws_internet_gateway.gw.id
}