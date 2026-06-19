

### Example of how to call the module


```terraform

module "tg" {
  source = ""

  common_config = {
    name            = var.name
    tags            = var.tags
    resource_number = 1
    environment     = var.environment
  }

  tg_config = {
    port     = 80
    vpc_id   = module.vpc.id
    protocol = "HTTP"
  }
}

```
