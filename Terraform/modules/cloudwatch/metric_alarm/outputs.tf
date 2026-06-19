output "arn" {
  description = "arn metric alarm"
  value = values({ for k, v in aws_cloudwatch_metric_alarm.cw_alarm : k => v.arn  })
}

output "id" {
  description = "id metric alarm"
  value = values({ for k, v in aws_cloudwatch_metric_alarm.cw_alarm : k => v.id  })
}