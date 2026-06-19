
variable "common_config" {
  description = "Iam policy commun config"

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

variable "policy_config" {
  description = "Iam policy Configuration"

  type = map(object({
    description     = string
    iam_version     = optional(string, "2012-10-17")
    resource_number = string
    statements = list(object({
      Sid       = string
      Resource  = list(string)
      Effect    = string
      Action    = list(string)
      Condition = optional(any, {})
    }))

  }))
}
