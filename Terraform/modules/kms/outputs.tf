output "key_alias_name" {
  value = aws_kms_alias.this.name
}

output "kms_key_id" {
  value = aws_kms_key.kms.id
}

output "arn" {
  value = aws_kms_key.kms.arn
}
