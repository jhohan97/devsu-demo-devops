
resource "aws_iam_role" "this" {

  for_each              = var.role_config
  name                  = "iam-role-${each.key}-${var.common_config.name}-${var.common_config.environment}-${format("%02d", each.value.resource_number)}"
  force_detach_policies = each.value.force_detach_policies
  permissions_boundary  = each.value.role_permissions_boundary
  managed_policy_arns   = each.value.managed_policy_arns

  assume_role_policy = jsonencode({
    Version   = each.value.iam_version
    Statement = [for statement in each.value.statements : statement]
  })

  tags = merge(
    var.common_config.tags,
    {

      Name       = lower("iam-role-${each.key}-${var.common_config.name}-${var.common_config.environment}-${format("%02d", each.value.resource_number)}")

      managed-by = "Terraform"
    }
  )
}
