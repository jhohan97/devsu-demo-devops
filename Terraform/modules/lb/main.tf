
resource "aws_lb" "this" {
  name                                        = local.name
  subnets                                     = var.lb_config.subnets
  internal                                    = var.lb_config.internal
  name_prefix                                 = var.lb_config.name_prefix
  idle_timeout                                = var.lb_config.idle_timeout
  enable_http2                                = var.lb_config.enable_http2
  security_groups                             = var.lb_config.security_groups
  ip_address_type                             = var.lb_config.ip_address_type
  load_balancer_type                          = var.lb_config.load_balancer_type
  preserve_host_header                        = var.lb_config.preserve_host_header
  enable_waf_fail_open                        = var.lb_config.enable_waf_fail_open
  enable_xff_client_port                      = var.lb_config.enable_xff_client_port
  desync_mitigation_mode                      = var.lb_config.desync_mitigation_mode
  customer_owned_ipv4_pool                    = var.lb_config.customer_owned_ipv4_pool
  drop_invalid_header_fields                  = var.lb_config.drop_invalid_header_fields
  enable_deletion_protection                  = var.lb_config.enable_deletion_protection
  xff_header_processing_mode                  = var.lb_config.xff_header_processing_mode
  enable_cross_zone_load_balancing            = var.lb_config.enable_cross_zone_load_balancing
  enable_tls_version_and_cipher_suite_headers = var.lb_config.enable_tls_version_and_cipher_suite_headers

  dynamic "access_logs" {
    for_each = local.access_logs

    content {
      bucket  = access_logs.value.bucket
      prefix  = access_logs.value.prefix
      enabled = access_logs.value.enabled
    }
  }

  dynamic "subnet_mapping" {
    for_each = local.subnet_mapping

    content {
      subnet_id            = subnet_mapping.value.subnet_id
      ipv6_address         = subnet_mapping.value.ipv6_address
      allocation_id        = subnet_mapping.value.allocation_id
      private_ipv4_address = subnet_mapping.value.private_ipv4_address
    }
  }

  tags = merge(
    var.common_config.tags,
    {
      Name      = local.name
      ManagedBy = "Terraform"
    }
  )
}

resource "aws_lb_listener" "this" {
  for_each = {for idx, listener in var.lb_listener : idx => listener}

  port              = each.value.port
  protocol          = each.value.protocol
  ssl_policy        = each.value.ssl_policy
  certificate_arn   = each.value.certificate_arn
  load_balancer_arn = aws_lb.this.arn

  default_action {
    type             = each.value.default_action.type
    target_group_arn = each.value.default_action.target_group_arn
  }
}
