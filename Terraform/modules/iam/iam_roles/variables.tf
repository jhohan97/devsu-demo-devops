
variable "common_config" {
  description = "IAM-role commun config"

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

variable "role_config" {
  description = "IAM-role Configuration"

  type = map(object({

    path                      = optional(string, "/")
    description               = string
    iam_version               = optional(string, "2012-10-17")
    resource_number           = string
    managed_policy_arns       = optional(list(string))
    force_detach_policies     = optional(bool, true)
    role_permissions_boundary = optional(any, null)

    statements = list(object({
      Sid       = string
      Effect    = string
      Action    = list(string)
      Principal = optional(map(any))
      Condition = optional(any,{})
    }))

  }))
}
