#------------------------------------------------------------------------------
# AWS Virtual Private Cloud
#------------------------------------------------------------------------------
resource "aws_vpc" "this" {
  cidr_block           = var.vpc_config.cidr_block
  instance_tenancy     = var.vpc_config.instance_tenancy
  enable_dns_support   = var.vpc_config.enable_dns_support
  enable_dns_hostnames = var.vpc_config.enable_dns_hostnames

  tags = merge(
    var.common_config.tags,
    {
      Name = local.name
      managed-by = "Terraform"
    }
  )
}
