
variable "name" {
  description = "Name of the application"
  type        = string
}

variable "environment" {
  description = "ambiente a desplegar"
  type        = string
  default     = "dev"
}

variable "resource_number" {
  description = "Cantidad de números a generar"
  type        = string
  default     = "1"
}

variable "vpc_id" {
  description = "the vpc"
  type        = string
}

variable "rules" {
  description = "The security group rules"
  type = object({

    ingress = optional(map(object({
      cidr_blocks = optional(list(string))
      to_port     = number
      from_port   = number
      protocol    = string
      description = string
      source_sg   = optional(list(string))
    })))

    egress = optional(map(object({
      cidr_blocks = list(string)
      to_port     = number
      from_port   = number
      protocol    = string
      description = string
    })))

  })
}

variable "tags" {
  type        = map(string)
  description = "tags"

  validation {
    condition = alltrue([
      for tag in ["app-name", "domain", "application-code", "ppto-line", "cell", "tribe"] : contains(keys(var.tags), tag)
    ])
    error_message = "The tags map must include the key-value pairs for: 'app-name', 'domain', 'application-code', 'ppto-line', 'cell' and 'tribe'."
  }
}