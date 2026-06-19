module "lb" {
  source = "../Terraform/modules/lb"

  common_config = {
    name            = var.name
    tags            = var.tags
    resource_number = 1
    environment     = var.environment
  }

  lb_config = {
    subnets            = module.subnet_public.id
    internal           = true
    security_groups    = [module.security_group_alb.group_id]
    load_balancer_type = "application"
  }

  lb_listener = {
    port_lb     = "443"
    protocol_lb = "HTTPS"

    default_action = {
      type             = "forward"
      target_group_arn = module.tg.arn
    }
  }
}