resource "aws_cloudwatch_dashboard" "dash" {
  dashboard_name = "cwch-dash-${var.common_config.name}-${var.common_config.environment}-${var.resource_number}"
  dashboard_body = var.dashboard_body
}