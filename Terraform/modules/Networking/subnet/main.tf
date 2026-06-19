#------------------------------------------------------------------------------
# AWS Subnets
#------------------------------------------------------------------------------
resource "aws_subnet" "this" {
  count = length(var.subnet_config.cidr_block)

  vpc_id                  = var.subnet_config.vpc_id
  cidr_block              = var.subnet_config.cidr_block[count.index]
  availability_zone       = var.subnet_config.availability_zone[count.index]
  map_public_ip_on_launch = var.subnet_config.map_public_ip_on_launch
  assign_ipv6_address_on_creation = var.subnet_config.assign_ipv6_address_on_creation

  tags = merge(
    var.common_config.tags,
    {
      Name = format("snet-${local.transformed_type}-${trimspace(var.common_config.name)}-${trimspace(var.common_config.environment)}-${format("%02d", count.index + 1)}")
      managed-by = "Terraform"
    }
  )
}