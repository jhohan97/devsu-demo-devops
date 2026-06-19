variable "common_config" {
  description = " Target group common config"

  type = object({
    name            = string
    tags            = map(string)
    environment     = string
    resource_number = string
  })

  validation {
    condition = alltrue([
      for tags in ["app-name"] : contains(keys(var.common_config.tags), tags)
    ])
    error_message = "The tags map must include the key-value pairs for: 'app-name'."
  }
}

variable "tg_config" {
  description = " Lb target group config"
  type = object({
    port                               = number
    protocol                           = string
    vpc_id                             = optional(string)
    slow_start                         = optional(number)
    name_prefix                        = optional(string)
    target_type                        = optional(string)
    ip_address_type                    = optional(string)
    protocol_version                   = optional(string)
    proxy_protocol_v2                  = optional(bool)
    preserve_client_ip                 = optional(bool)
    deregistration_delay               = optional(number)
    connection_termination             = optional(bool)
    load_balancing_algorithm_type      = optional(string)
    load_balancing_cross_zone_enabled  = optional(string)
    lambda_multi_value_headers_enabled = optional(bool)

    health_check = optional(object({
      path                = optional(string)
      port                = optional(string)
      timeout             = optional(number)
      matcher             = optional(string)
      enabled             = optional(bool)
      protocol            = optional(string)
      interval            = optional(number)
      healthy_threshold   = optional(number)
      unhealthy_threshold = optional(number)
    }))

    stickiness = optional(object({
      type            = optional(string)
      enabled         = optional(bool)
      cookie_name     = optional(string)
      cookie_duration = optional(number)
    }))

    target_failover = optional(object({
      on_unhealthy      = optional(string)
      on_deregistration = optional(string)
    }))

    target_health_state = optional(object({
      enable_unhealthy_connection_termination = bool
    }))
  })
}

variable "target_attachment"{
  description = "Target group attachment"
  type = list(object({
    id   = string
    port = string
  }))
}