
### Example of how to call the module

IMPORTANT: We periodically release versions for the components. Since, master branch may have breaking changes, best practice would be to use a released version in form of a tag (e.g. ?ref=x.y.z)

```terraform

module "route53_resolver" {
  source = ""

  common_config = {
    name            = var.name
    tags            = var.tags
    environment     = var.environment
    resource_number = 1
  }

  resolver_config = [
    {
      vpc_id           = module.vpc.id
      resolver_rule_id = "rslvr-rr-3a7f21b8c40d4388b"
    },
    {
      vpc_id           = module.vpc.id
      resolver_rule_id = "rslvr-rr-8b0f0fa39e3a44ec8"
    }
  ]
}

```