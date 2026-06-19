

### Example of how to call the module

IMPORTANT: We periodically release versions for the components. Since, master branch may have breaking changes, best practice would be to use a released version in form of a tag (e.g. ?ref=x.y.z)

```terraform

module "igw" {
  source = ""

  vpc_id        = module.vpc.vpc_id

  common_config      = {
    name             = var.name
    tags             = var.tags
    environment      = var.environment
    resource_number  = 1
  }

}

```
