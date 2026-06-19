
locals {
  name                = "tg-${var.common_config.name}-${var.common_config.environment}-${format("%02d", var.common_config.resource_number)}"
  stickiness          = var.tg_config.stickiness != null ? { 0 = var.tg_config.stickiness } : {}
  health_check        = var.tg_config.health_check != null ? { 0 = var.tg_config.health_check } : {}
  target_failover     = var.tg_config.target_failover != null ? { 0 = var.tg_config.target_failover } : {}
  target_health_state = var.tg_config.target_health_state != null ? { 0 = var.tg_config.target_health_state } : {}
}

resource "aws_lb_target_group" "this" {
  name                               = local.name
  port                               = var.tg_config.port
  vpc_id                             = var.tg_config.vpc_id
  protocol                           = var.tg_config.protocol
  slow_start                         = var.tg_config.slow_start
  target_type                        = var.tg_config.target_type
  name_prefix                        = var.tg_config.name_prefix
  ip_address_type                    = var.tg_config.ip_address_type
  protocol_version                   = var.tg_config.protocol_version
  proxy_protocol_v2                  = var.tg_config.proxy_protocol_v2
  preserve_client_ip                 = var.tg_config.preserve_client_ip
  deregistration_delay               = var.tg_config.deregistration_delay
  connection_termination             = var.tg_config.connection_termination
  load_balancing_algorithm_type      = var.tg_config.load_balancing_algorithm_type
  load_balancing_cross_zone_enabled  = var.tg_config.load_balancing_cross_zone_enabled
  lambda_multi_value_headers_enabled = var.tg_config.lambda_multi_value_headers_enabled

  dynamic "health_check" {
    for_each = local.health_check

    content {
      path                = health_check.value.path
      port                = health_check.value.port
      enabled             = health_check.value.enabled
      matcher             = health_check.value.matcher
      timeout             = health_check.value.timeout
      protocol            = health_check.value.protocol
      interval            = health_check.value.interval
      healthy_threshold   = health_check.value.healthy_threshold
      unhealthy_threshold = health_check.value.unhealthy_threshold
    }
  }

  dynamic "stickiness" {
    for_each = local.stickiness

    content {
      type            = stickiness.value.type
      enabled         = stickiness.value.enabled
      cookie_name     = stickiness.value.cookie_name
      cookie_duration = stickiness.value.cookie_duration
    }
  }

  dynamic "target_failover" {
    for_each = local.target_failover

    content {
      on_unhealthy      = target_failover.value.on_unhealthy
      on_deregistration = target_failover.value.on_deregistration
    }
  }

  dynamic "target_health_state" {
    for_each = local.target_health_state

    content {
      enable_unhealthy_connection_termination = target_health_state.value.enable_unhealthy_connection_termination
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

resource "aws_lb_target_group_attachment" "this" {
  for_each = {for idx, attachment in var.target_attachment : idx => attachment}
  
  target_group_arn = aws_lb_target_group.this.arn
  target_id        = each.value.id
  port             = each.value.port
}
