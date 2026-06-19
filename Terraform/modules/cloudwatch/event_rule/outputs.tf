
output "id" {
  description = "event rule id"
  value       = values({ for k, v in aws_cloudwatch_event_rule.this : k => v.id })
}

output "arn" {
  description = "event rule arn"
  value       = values({ for k, v in aws_cloudwatch_event_rule.this : k => v.arn })
}
