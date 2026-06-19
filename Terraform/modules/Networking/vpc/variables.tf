
variable "common_config" {
  description = "VPC common config"

  type = object({
    name            = optional(string)
    environment     = optional(string)
    resource_number = optional(string)
    tags            = map(string)
  })

  validation {
    condition = var.common_config.tags != null ? alltrue([
      for tags in ["app-name"] : contains(keys(var.common_config.tags), tags)
    ]) : true

    error_message = "The tags map must include the key-value pairs for: 'app-name'."
  }
}

variable "vpc_config" {
  description = "VPC config"
  
  type = object({
    name                   = optional(string)
    cidr_block             = string
    instance_tenancy       = optional(string)
    enable_dns_support     = bool
    enable_dns_hostnames   = bool
  })
}

variable "secondary_cidr" {
  description = "CIDR secondary"
  
  type = string
  default = null
}