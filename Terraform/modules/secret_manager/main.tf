
resource "aws_secretsmanager_secret" "this" {
  for_each                = var.secrets_config.secrets_manager
  name                    = var.secrets_config.is_for_secretstores ? "sm-${each.key}-${var.common_config.environment}" : "sm-${var.common_config.name}-${var.common_config.environment}-${format("%02d", each.key)}"

  
  kms_key_id              = each.value.kms_key_id
  description             = each.value.description
  recovery_window_in_days = each.value.recovery_window_in_days

  tags = merge(
    var.secrets_config.is_for_secretstores ? each.value.tags : var.common_config.tags,
    {
      name       = var.secrets_config.is_for_secretstores ? "sm-${each.key}-${var.common_config.environment}" : "sm-${var.common_config.name}-${var.common_config.environment}-${format("%02d", each.key)}"
      managed-by = "Terraform"
    }
  )
}

resource "aws_secretsmanager_secret_version" "this" {
  for_each = var.secrets_config.list_secrets != null ? var.secrets_config.list_secrets : {}

  secret_id     = aws_secretsmanager_secret.this[each.key].id
  secret_string = jsonencode(each.value.secret_string)
}

resource "aws_secretsmanager_secret_policy" "this" {
  for_each = var.secrets_config.statements != null ? var.secrets_config.statements : {}

  secret_arn = aws_secretsmanager_secret.this[each.key].arn
  policy = jsonencode({
    Version   = var.secrets_config.iam_version
    Statement = [for statement in each.value.statements : statement]
  })
}

resource "aws_secretsmanager_secret_rotation" "this" {
  for_each = var.secrets_config.secret_rotation != null ? var.secrets_config.secret_rotation : {}

  secret_id           = aws_secretsmanager_secret.this[each.key].arn
  rotation_lambda_arn = each.value.rotation_lambda_arn

  rotation_rules {
    automatically_after_days = each.value.rotation_rules
  }
}

