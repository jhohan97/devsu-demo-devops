module "vpc_config" {
  source = "Terraform/modules/Networking/vpc"

  common_config = {
    name           = var.name
    environment    = var.environment
    resource_number = 01
    tags           = var.tags
  }

  name                    = "vpc-${var.environment}"
  cidr_block              = "10.0.0.0/16"
  instance_tenancy        = "default"
  enable_dns_support      = true
  enable_dns_hostnames    = true
}
