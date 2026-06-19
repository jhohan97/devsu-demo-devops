
variable "common_config" {
  description = "Iam policy commun config"

  type = object({
    name      = string
    role_name = string
  })

}

variable "policy_config" {
  description = "Iam policy Configuration"

  type = map(object({
    iam_version     = optional(string, "2012-10-17")
    resource_number = string
    statements = list(object({
      Sid      = string
      Effect   = string
      Action   = list(string)
      Resource = list(string)
      Condition = optional(list(object({
        condition_operator = string
        values = list(object({
          condition_key   = string
          condition_value = list(string)
        }))

      })))
    }))

  }))
}
