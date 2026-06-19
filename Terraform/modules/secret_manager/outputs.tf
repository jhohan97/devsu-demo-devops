
output "id" {
  description = "Secret string"
  value       = values({ for k, v in aws_secretsmanager_secret.this : k => v.id })
}

output "arn" {
  description = "Secret string"
  value       = values({ for k, v in aws_secretsmanager_secret.this : k => v.id })
}

output "arn_map" {
  value = {
    for k, v in aws_secretsmanager_secret.this : k => v.id
  }
}