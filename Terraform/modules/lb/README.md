
### Example of how to call the module

```terraform

module "lb" {
  source = ""

  common_config = {
    name            = var.name
    tags            = var.tags
    resource_number = 1
    environment     = var.environment
  }

  lb_config = {
    subnets            = module.vpc.private_subnets_ids
    internal           = true
    security_groups    = [module.security_group_alb.group_id]
    load_balancer_type = "application"
  }

  lb_listener = {
    port_lb     = "80"
    protocol_lb = "HTTP"

    default_action = {
      type             = "forward"
      target_group_arn = module.target_group.arn
    }
  }
}
```
