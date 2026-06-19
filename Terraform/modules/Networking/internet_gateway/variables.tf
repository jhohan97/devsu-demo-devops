
variable "vpc_id" {
  description = "vpc id"
  type        = string
}

variable "common_config" {
  description = "Internet gateway common config"

  type = object({
    name            = string
    environment     = string
    resource_number = string
    tags            = map(string)
  })

  validation {
    condition = alltrue([
      for tags in ["app-name", "domain", "application-code", "ppto-line", "cell", "tribe"] : contains(keys(var.common_config.tags), tags)
    ])
    error_message = "The tags map must include the key-value pairs for: 'app-name', 'domain', 'application-code', 'ppto-line', 'cell' and 'tribe'."
  }
}
