
variable "common_config" {
  description = "VPC common config"

  type = object({
    name            = string
    tags            = map(string)
    resource_number = optional(string)
    environment     = string
  })

  validation {
    condition = alltrue([
      for tags in ["app-name"] : contains(keys(var.common_config.tags), tags)
    ])
    error_message = "The tags map must include the key-value pairs for: 'app-name'."
  }
}

variable "subnet_config" {
  description = "Subnet config"

  type = object({
    type                            = string
    vpc_id                          = string
    cidr_block                      = list(string)
    availability_zone               = list(string)
    map_public_ip_on_launch         = bool
    assign_ipv6_address_on_creation = optional(bool, false)
  })

  validation {
    condition = length(var.subnet_config.availability_zone) >= length(var.subnet_config.cidr_block)
    error_message = "The number of CIDRs does not match the number of AVAILABILITY ZONE."
  }

  validation {
    condition     = var.subnet_config.type == "public" || var.subnet_config.type == "private" || var.subnet_config.type == "protected"
    error_message = "The variable 'type' must be 'public', 'private' or 'protected'."
  }
}   