output "dashboard_arn" {
  description = "dashboard arn"
  value       = aws_cloudwatch_dashboard.dash.dashboard_arn
}