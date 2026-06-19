
variable "common_config" {
  description = "r53 resolver association commun config"

  type = object({
    name            = string
    environment     = string
    resource_number = number
  })
}

variable "resolver_config" {
  description = "r53 resolver association config"

  type = list(object({
   vpc_id           = string
   resolver_rule_id = string
  }))
}
