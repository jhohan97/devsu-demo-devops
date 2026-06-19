
output "id" {
  description = "tg id"
  value       = aws_lb_target_group.this.id
}
output "arn" {
  description = "tg arn"
  value       = aws_lb_target_group.this.arn
}