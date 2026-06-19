
resource "aws_route53_resolver_rule_association" "this" {
  for_each = local.resolver 
  
  name             = "r53-resolver-${var.common_config.name}-${var.common_config.environment}-${format("%02d", var.common_config.resource_number)}"
  vpc_id           = each.value.vpc_id
  resolver_rule_id = each.value.resolver_rule_id
}