module "route53_association" {
  source = "../Terraform/modules/route53/association"

  zone_id    = module.route53_zone.id
  vpc_id     = module.vpc_config.id 
  vpc_region = "us-east-1"
}

module "route53_authorization" {
  source = "../Terraform/modules/route53/authorization"

  vpc_id     = module.vpc_config.id 
  zone_id    = module.route53_zone.id
  vpc_region = "us-east-1"
}

module "r53_record" {
  source = "../Terraform/modules/route53/record"

  name = "gate-admin"
  environment = var.environment

  record_settings = [
    {
      ttl             = 300
      name            = "gate-admin"
      type            = "A"
      zone_id         = var.zone_id
      records         = ["<IP_ADDRESS>"]
      resource_number = 1

      weighted_routing_policy = {
        weight = 10
      }
    },
    {
      ttl             = 300
      name            = "gate-user"
      type            = "A"
      zone_id         = var.zone_id
      records         = ["<IP_ADDRESS>"]
      resource_number = 1

      weighted_routing_policy = {
        weight = 10
      }
    }
  ]
}

module "route53_zone" {
  source = ""

  common_config = {
    name            = var.name
    tags            = var.tags
    environment     = var.environment
    resource_number = 1
  }

  zone_config = {
    comment       = "prueba asociacion r53 dev zone"
    domain_name   = "accesment.devsu.com"
    force_destroy = false

    vpc = [
      {
        id     = module.vpc_config.id
        region = "us-east-1"
      }
    ]
  }
}