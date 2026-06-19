
locals {
  resolver = { for idx, resolver in var.resolver_config : idx => resolver }
}