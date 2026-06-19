locals {
  name           = "lb-${var.common_config.name}-${var.common_config.environment}-${format("%02d", var.common_config.resource_number)}"
  access_logs    = var.lb_config.access_logs != null ? { 0 = var.lb_config.access_logs } : {}
  subnet_mapping = var.lb_config.subnet_mapping != null ? [1] : []
}
