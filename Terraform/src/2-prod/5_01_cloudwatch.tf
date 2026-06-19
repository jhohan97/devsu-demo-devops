module "dashboard" {
  source = "../Terraform/modules/cloudwatch/dashboard"

  common_config = {
    name        = var.name
    environment = var.environment
    tags        = var.tags
  }
  resource_number = 01
  dashboard_body = ""
}