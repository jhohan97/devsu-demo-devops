
variable "common_config" {
  description = "r53 zone commun config"

  type = object({
    name            = string
    tags            = map(string)
    environment     = string
    resource_number = number
  })

  validation {
    condition = alltrue([
      for tags in ["app-name"] : contains(keys(var.common_config.tags), tags)
    ])

    error_message = "The tags map must include the key-value pairs for: \"app-name\"."
  }
}

variable "zone_config" {
  description = "Zone parameters"

  type = object({
    comment           = string
    domain_name       = string
    force_destroy     = bool
    delegation_set_id = optional(string, null)

    vpc = optional(list(object({
      id     = string
      region = string
    })))

  })
}
