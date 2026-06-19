### GENERAL
variable "name" {
  description = "name"
  type        = string
  default     = "devsu"
}

variable "environment" {
  description = "environment"
  type        = string
  default     = "dev"
}

variable "region" {
  description = "AWS region used to deploy whole infrastructure"
  type        = string
  default     = "us-east-1"
}


variable "tags" {
  type = map(string)
  default = {
    project-name = "DevSu-assessment"
    app-name     = "DevSu"
  }
}

variable "cluster_name" {
  type = string
  default = "devsu-cluster"
}
