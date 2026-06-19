
variable "common_config" {
  description = "lb common config"

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

variable "lb_config" {
  type = object({
    subnets                                     = list(string)
    internal                                    = bool
    name_prefix                                 = optional(string)
    idle_timeout                                = optional(number)
    enable_http2                                = optional(bool)
    security_groups                             = optional(list(string))
    ip_address_type                             = optional(string)
    load_balancer_type                          = optional(string)
    preserve_host_header                        = optional(bool)
    enable_waf_fail_open                        = optional(bool)
    enable_xff_client_port                      = optional(bool)
    desync_mitigation_mode                      = optional(string)
    customer_owned_ipv4_pool                    = optional(string)
    drop_invalid_header_fields                  = optional(bool)
    enable_deletion_protection                  = optional(bool)
    xff_header_processing_mode                  = optional(string)
    enable_cross_zone_load_balancing            = optional(bool)
    enable_tls_version_and_cipher_suite_headers = optional(bool)

    access_logs = optional(object({
      bucket  = string
      prefix  = string
      enabled = bool
    }))

    subnet_mapping = optional(map(object({
      subnet_id            = string
      ipv6_address         = optional(string)
      allocation_id        = optional(string)
      private_ipv4_address = optional(string)
    })))
  })
}

variable "lb_listener" {
  type = list(object({
    port              = string
    protocol          = string
    ssl_policy        = optional(string)
    certificate_arn   = optional(string)
    load_balancer_arn = optional(string)

    default_action = object({
      type             = string
      target_group_arn = string
    })
  }))
}
