variable "common_config" {
  description = "Instance parameters common config"

  type = object({
    name        = string
    environment = string
    tags        = map(string)
  })

  validation {
    condition = alltrue([
      for tags in ["app-name"] : contains(keys(var.common_config.tags), tags)
    ])
    error_message = "The tags map must include the key-value pairs for: 'app-name'."
  }
}

variable "alarm_config" {
  description = "Alarm configuration variables"
  type = map(object({
    comparison_operator       = string
    evaluation_periods        = number
    resource_number           = string
    metric_name               = optional(string)
    namespace                 = optional(string)
    period                    = optional(string)
    statistic                 = optional(string)
    threshold                 = optional(string)
    actions_enabled           = optional(bool)
    alarm_actions             = optional(list(string))
    alarm_description         = optional(string)
    dimensions                = optional(map(string))
    insufficient_data_actions = optional(list(string))
  }))
}