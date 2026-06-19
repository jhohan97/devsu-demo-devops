variable "common_config" {
  description = "Instance parameters common config"

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

variable "dashboard_body" {
  description = "Dashboard variable"
  type        = string
}

variable "resource_number" {
  description = "Cantidad de números a generar"
  type        = string
  default     = "01"
}