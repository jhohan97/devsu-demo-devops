

output "arn" {
  description = "Policy arn"
  value       = { for k, v in aws_iam_policy.this : k => v.arn }
}

output "id" {
  description = "Policy id"
  value       = { for k, v in aws_iam_policy.this : k => v.id }
}

output "name" {
  description = "Policy name"
  value       = { for k, v in aws_iam_policy.this : k => v.name }
}