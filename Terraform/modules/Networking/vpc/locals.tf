
locals {
  name = var.vpc_config.name != null ? var.vpc_config.name : "vpc-${var.common_config.name}-${var.common_config.environment}-${format("%02d", var.common_config.resource_number)}"
}