resource "aws_iam_policy" "this" {

  for_each = var.policy_config

  name        = "iam-policy-${each.key}-${var.common_config.name}-${var.common_config.environment}-${format("%02d", each.value.resource_number)}"

  description = each.value.description

  policy = jsonencode({
    Version   = each.value.iam_version
    Statement = [for statement in each.value.statements : statement]
  })

  tags = merge(
    var.common_config.tags,
    {

      Name       = lower("iam-policy-${each.key}-${var.common_config.name}-${var.common_config.environment}-${format("%02d", each.value.resource_number)}")

      managed-by = "Terraform"
    }
  )
}