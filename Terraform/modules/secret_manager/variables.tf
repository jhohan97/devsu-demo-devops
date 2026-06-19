
variable "common_config" {
  description = "Cluster commun config"

  type = object({
    name        = string
    environment = string
    tags        = map(string)
  })

  validation {
    condition = alltrue([
      for tags in ["app-name", "domain", "application-code", "ppto-line"] : contains(keys(var.common_config.tags), tags)
    ])
    error_message = "The tags map must include the key-value pairs for: 'app-name', 'domain', 'application-code', 'ppto-line', 'cell' and 'tribe'."
  }
}

variable "secrets_config" {
  description = "Configuration secrets variables"
  type = object({

    secrets_manager = map(object({
      description             = string
      kms_key_id              = optional(string)
      recovery_window_in_days = optional(number, 30)
      tags                    = optional(map(string)) # se usa cuando is_for_secretstores esta en true
    }))

    list_secrets = optional(map(object({
      secret_string = map(string)
    })))

    iam_version = optional(map(object({
      default = optional(string, "2012-10-17")
    })))

    statements = optional(map(object({
      Sid       = optional(string)
      Effect    = string
      Principal = map(any)
      Resource  = list(string)
      Action    = list(string)
    })))

    secret_rotation = optional(map(object({
      rotation_lambda_arn = string
      rotation_rules      = number
    })))

    is_for_secretstores = optional(bool, false)
  })
}
