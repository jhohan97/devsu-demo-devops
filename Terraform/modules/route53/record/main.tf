
resource "aws_route53_record" "this" {
  for_each = {for idx, record in var.record_settings: idx => record}

  ttl            = each.value.ttl
  name           = each.value.name
  type           = each.value.type
  records        = each.value.records
  zone_id        = each.value.zone_id
  set_identifier = "record-${var.name}-${var.environment}-${format("%02d", each.value.resource_number)}"
 
  dynamic "weighted_routing_policy" {
    for_each = each.value.weighted_routing_policy != null ? [1] : []
    content {
      weight = each.value.weighted_routing_policy.weight
    }
  }

  dynamic "alias" {
    for_each = each.value.alias != null && each.value.type == "A" && each.value.records == null && each.value.ttl == null ? [1] : []
    content {
      name                   = each.value.alias.name
      zone_id                = each.value.alias.zone_id
      evaluate_target_health = each.value.alias.evaluate_target_health
    }
  }
}