
resource "aws_kms_key" "kms" {
  description = "kms-${var.name}-${var.environment}-${var.resource_number}"
  policy = jsonencode({
    Version   = var.iam_version
    Statement = [for statement in var.statements : statement]
  })

  tags = merge(
    var.tags,
    {
      "name"       = "kms-${var.name}-${var.environment}-${var.resource_number}"
      "managed-by" = "Terraform"
    }
  )
}

resource "aws_kms_alias" "this" {
  name          = "alias/${var.name}-${var.environment}-${var.resource_number}"
  target_key_id = aws_kms_key.kms.key_id
}

resource "aws_kms_grant" "this" {
  name              = "grand-${var.name}-${var.environment}-${var.resource_number}"
  key_id            = aws_kms_key.kms.key_id
  grantee_principal = var.role
  operations        = ["Encrypt", "Decrypt", "GenerateDataKey"]
}



