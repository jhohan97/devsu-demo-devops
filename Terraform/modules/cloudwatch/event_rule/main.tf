
locals {
  aws_cloudwatch_event_rule   = var.cw_config != null ? var.cw_config : {}
  aws_cloudwatch_event_target = var.event_target != null ? aws_cloudwatch_event_rule.this : {}
}

resource "aws_cloudwatch_event_rule" "this" {
  for_each = local.aws_cloudwatch_event_rule

  name                = "cwch-er-${var.common_config.name}-${var.common_config.environment}-${format("%02d", each.value.resource_number)}"
  description         = each.value.description
  schedule_expression = each.value.schedule_expression

  event_pattern = each.value.event_pattern != null ? jsonencode({
    source      = each.value.event_pattern.source,
    resources   = each.value.event_pattern.resources,
    detail_type = each.value.event_pattern.detail_type  

    detail = {
      action-type = each.value.event_pattern.detail.action-type
    }
  }) : null

  tags = merge(
    var.common_config.tags,
    {
      name       = "cwch-er-${var.common_config.name}-${var.common_config.environment}-${format("%02d", each.value.resource_number)}"
      managed-by = "Terraform"
    }
  )
}

resource "aws_cloudwatch_event_target" "this" {
  for_each = local.aws_cloudwatch_event_target

  arn       = var.event_target.arn
  rule      = each.value.name
  role_arn  = var.event_target.role_arn
  target_id = var.event_target.target_id
}