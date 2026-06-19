

### Example of how to call the module


```terraform

module "dashboard" {
  source = ""

  common_config = {
    name        = var.name
    environment = var.environment
    tags        = var.tags
  }

  dashboard_body = file("dashboardpaloalto.json")
}


