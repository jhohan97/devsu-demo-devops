
variable "name" {
  description = "Resource name"
  type        = string
}

variable "environment" {
  description = "Environment to deploy"
  type        = string
}

variable "record_settings" {
  description = "Settings for the Route 53 record"
  type = list(object({ 
    ttl             = optional(number)
    name            = string
    type            = string
    zone_id         = string
    records         = list(string)
    resource_number = string
    
    weighted_routing_policy = optional(object({
      weight = number
    }))

    alias = optional(object({
      name                   = string
      zone_id                = string
      evaluate_target_health = bool
    }))

  }))
}