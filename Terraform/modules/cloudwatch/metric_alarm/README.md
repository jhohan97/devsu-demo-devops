### Example of how to call the module

```terraform

module "metric_alarm" {
  source = ""

  common_config = {
    name        = var.name
    environment = var.environment
    tags        = var.tags
  }

  alarm_config = {
    alarm-example-01 = {
      comparison_operator = "GreaterThanOrEqualToThreshold"
      evaluation_periods  = 2
      resource_number     = "01"
      metric_name         = "CPUUtilization"
      namespace           = "AWS/EC2"
      period              = "60"
      statistic           = "Maximum"
      threshold           = "75"
      actions_enabled     = true
      alarm_actions       = [aws_sns_topic.cloud_watch_alarm_topic[5].arn]
      alarm_description   = "This metric monitors pan-logs-high-cpu-2"

      dimensions = {
        InstanceId = "i-067270d55aa49d140"
      }

      insufficient_data_actions = []
    }

    alarm-example-02 = {
      comparison_operator = "GreaterThanOrEqualToThreshold"
      evaluation_periods  = 2
      resource_number     = "02"
      metric_name         = "CPUUtilization"
      namespace           = "AWS/EC2"
      period              = "60"
      statistic           = "Maximum"
      threshold           = "75"
      actions_enabled     = "true"
      alarm_actions       = [aws_sns_topic.cloud_watch_alarm_topic[4].arn]
      alarm_description   = "This metric monitors pan-logs-high-cpu-2"

      dimensions = {
        InstanceId = "i-067270d55aa49d140"
      }

      insufficient_data_actions = []
    }
  }
}

```