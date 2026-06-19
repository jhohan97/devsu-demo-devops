module "tg" {
  source = "../Terraform/modules/target_group"

  common_config = {
    name            = var.name
    tags            = var.tags
    resource_number = 1
    environment     = var.environment
  }

  tg_config = {
    port     = 443
    vpc_id   = module.vpc_config.id
    protocol = "HTTPS"
    health_check = {
      enabled             = true
      path                = "/"
      port                = "traffic-port"
      protocol            = "HTTPS"
      matcher             = "200-399"
      interval            = 30
      timeout             = 5
      healthy_threshold   = 2
      unhealthy_threshold = 2
    }
  }
}
