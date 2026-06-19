

### Example of how to call the module

IMPORTANT: We periodically release versions for the components. Since, master branch may have breaking changes, best practice would be to use a released version in form of a tag (e.g. ?ref=x.y.z)

```terraform

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
    domain_name   = "testr53dev.cloudnp.bpichincha.com"
    force_destroy = false

    vpc = [
      {
        id     = module.vpc.vpc_id
        region = "us-east-1"
      },
      {
        id     = "vpc-0ced10950faa72baa"
        region = "us-east-1"
      }
    ]
  }
}

```