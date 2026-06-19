resource "aws_cloudwatch_metric_alarm" "cw_alarm" {
  for_each = var.alarm_config

  alarm_name                = "cwch-alarm-${var.common_config.name}-${var.common_config.environment}-${format("%02d", each.value.resource_number)}"
  comparison_operator       = each.value.comparison_operator
  evaluation_periods        = each.value.evaluation_periods
  metric_name               = each.value.metric_name
  namespace                 = each.value.namespace
  period                    = each.value.period
  statistic                 = each.value.statistic
  threshold                 = each.value.threshold
  actions_enabled           = each.value.actions_enabled
  alarm_actions             = each.value.alarm_actions
  alarm_description         = each.value.alarm_description
  dimensions                = each.value.dimensions
  insufficient_data_actions = each.value.insufficient_data_actions

  tags = merge(
    var.common_config.tags,
    {
      name = "cwch-alarm-${var.common_config.name}-${var.common_config.environment}-${format("%02d", each.value.resource_number)}"
      managed-by = "Terraform"
    }
  )
}