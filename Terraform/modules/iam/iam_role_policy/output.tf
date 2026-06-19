output "id" {
  description = "Policy id"
  value       = { for k, v in aws_iam_role_policy.inline_role_policy : k => v.id }
}

output "name" {
  description = "Policy name"
  value       = { for k, v in aws_iam_role_policy.inline_role_policy : k => v.name }
}

output "role" {
  description = "Policy role"
  value       = { for k, v in aws_iam_role_policy.inline_role_policy : k => v.role }
}

output "policy" {
  description = "Policy"
  value       = { for k, v in aws_iam_role_policy.inline_role_policy : k => v.policy }
}