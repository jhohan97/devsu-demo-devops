
output "arn" {
  description = "Role arn"
  value       = { for k, v in aws_iam_role.this : k => v.arn }
}

output "name" {
  description = "Role name"
  value       = { for k, v in aws_iam_role.this : k => v.name }
}