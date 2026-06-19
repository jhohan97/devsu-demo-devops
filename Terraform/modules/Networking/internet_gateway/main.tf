resource "aws_internet_gateway" "gw" {
  vpc_id = var.vpc_id

  tags = merge(
    var.common_config.tags,
    {
      "Name"       = "igw-${var.common_config.name}-${var.common_config.environment}-${format("%02d", var.common_config.resource_number)}"
      "managed-by" = "Terraform"
    }
  )
}
