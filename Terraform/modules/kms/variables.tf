variable "name" {
  description = "Resource name"
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
  default     = "01"
}

variable "role" {
  type = string
}

variable "iam_version" {
  description = "IAM (Identity and Access Management) version."
  type        = string
  default     = "2012-10-17"
}

variable "statements" {
  description = "A list of policy statements specifying access permissions."
  type = list(object({
    Sid       = optional(string)
    Effect    = string
    Principal = map(any)
    Resource  = list(string)
    Action    = list(string)
  }))
}

variable "tags" {
  type        = map(string)
  description = "tags"

  validation {
    condition = alltrue([
      for tag in ["app-name"] : contains(keys(var.tags), tag)
    ])
    error_message = "The tags map must include the key-value pairs for: 'app-name'."
  }
}

