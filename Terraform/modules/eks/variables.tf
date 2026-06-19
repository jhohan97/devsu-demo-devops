variable "lb_config" {
  type = object({
    subnets                                     = list(string)
    internal                                    = bool
    name_prefix                                 = optional(string)
    idle_timeout                                = optional(number)
    enable_http2                                = optional(bool)
    security_groups                             = optional(list(string))
    ip_address_type                             = optional(string)
    load_balancer_type                          = optional(string)
    preserve_host_header                        = optional(bool)
    enable_waf_fail_open                        = optional(bool)
    enable_xff_client_port                      = optional(bool)
    desync_mitigation_mode                      = optional(string)
    customer_owned_ipv4_pool                    = optional(string)
    drop_invalid_header_fields                  = optional(bool)
    enable_deletion_protection                  = optional(bool)
    xff_header_processing_mode                  = optional(string)
    enable_cross_zone_load_balancing            = optional(bool)
    enable_tls_version_and_cipher_suite_headers = optional(bool)

    access_logs = optional(object({
      bucket  = string
      prefix  = string
      enabled = bool
    }))

    subnet_mapping = optional(map(object({
      subnet_id            = string
      ipv6_address         = optional(string)
      allocation_id        = optional(string)
      private_ipv4_address = optional(string)
    })))
  })
}



variable "cluster_name" {
  description = "Nombre del cluster EKS"
  type        = string
}

variable "cluster_version" {
  description = "Versión de Kubernetes para el cluster EKS"
  type        = string
  default     = "1.29"
}

variable "vpc_id" {
  description = "ID de la VPC donde se creará el cluster"
  type        = string
}

variable "subnet_ids" {
  description = "IDs de las subnets para el cluster (preferiblemente privadas)"
  type        = list(string)
}

variable "endpoint_private_access" {
  description = "Habilitar acceso privado al API endpoint del cluster"
  type        = bool
  default     = true
}

variable "endpoint_public_access" {
  description = "Habilitar acceso público al API endpoint del cluster"
  type        = bool
  default     = true
}

variable "public_access_cidrs" {
  description = "CIDRs permitidos para acceso público al API"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "cluster_log_types" {
  description = "Tipos de logs a habilitar para el control plane"
  type        = list(string)
  default     = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
}

variable "cluster_encryption_key_arn" {
  description = "ARN de la KMS key para encriptar secrets (opcional)"
  type        = string
  default     = null
}

variable "aws_auth_roles" {
  description = "Lista de roles IAM a agregar al aws-auth ConfigMap"
  type = list(object({
    rolearn  = string
    username = string
    groups   = list(string)
  }))
  default = []
}

variable "aws_auth_users" {
  description = "Lista de usuarios IAM a agregar al aws-auth ConfigMap"
  type = list(object({
    userarn  = string
    username = string
    groups   = list(string)
  }))
  default = []
}

variable "tags" {
  description = "Tags adicionales para todos los recursos"
  type        = map(string)
  default     = {}
}
