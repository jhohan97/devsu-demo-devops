
output "id" {
  description = "Load balancer id"
  value       = aws_lb.this.id
}
output "arn" {
  description = "Load balancer arn"
  value       = aws_lb.this.arn
}