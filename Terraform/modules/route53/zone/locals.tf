
locals {
  vpc = var.zone_config.vpc != null ? { for idx, vpc in var.zone_config.vpc : idx => vpc } : {}
}