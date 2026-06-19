
resource "aws_route53_zone" "this" {
  name              = var.zone_config.domain_name
  comment           = var.zone_config.comment
  force_destroy     = var.zone_config.force_destroy
  delegation_set_id = var.zone_config.delegation_set_id

  dynamic "vpc" {
    for_each = local.vpc
    
    content {
      vpc_id     = vpc.value.id
      vpc_region = vpc.value.region
    }
  }

  tags = merge(
    var.common_config.tags,
    {
      name       = "r53-zone-${var.common_config.name}-${var.common_config.environment}-${format("%02d", var.common_config.resource_number)}"
      managed-by = "Terraform"
    }
  )
}
