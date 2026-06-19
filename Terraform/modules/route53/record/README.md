
### Example of how to call the module

IMPORTANT: We periodically release versions for the components. Since, master branch may have breaking changes, best practice would be to use a released version in form of a tag (e.g. ?ref=x.y.z)

```terraform

module "r53_record" {
  source = ""

  name = "gate-admin"
  environment = var.environment

  record_settings = [
    {
      ttl             = 300
      name            = "gate-admin"
      type            = "A"
      zone_id         = var.zone_id
      records         = ["10.167.139.39"]
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
      records         = ["10.167.139.39"]
      resource_number = 1

      weighted_routing_policy = {
        weight = 10
      }
    }
  ]
}

```