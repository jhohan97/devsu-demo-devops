
variable "common_config" {
  description = "lambda common config"

  type = object({
    name            = string
    tags            = map(string)
    environment     = string
  })

  validation {
    condition = alltrue([
      for tags in ["app-name"] : contains(keys(var.common_config.tags), tags)
    ])
    error_message = "The tags map must include the key-value pairs for: 'app-name'."
  }
}

variable "cw_config" {
  description = "lambda config"

  type = map(object({

    description         = string
    resource_number     = optional(string)
    schedule_expression = optional(string)

    event_pattern = optional(object({
      source      = list(string)
      detail_type = list(string)
      resources   = list(string)

      detail = object({
        action-type = list(string)
      })
    }))
  }))
}

variable "event_target" {
  description = "event target config"

  type = object({
    arn                 = string
    target_id           = string
    role_arn            = optional(string)
  })

  default = null
}
