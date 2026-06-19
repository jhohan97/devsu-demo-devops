
### Example of how to call the module

IMPORTANT: We periodically release versions for the components. Since, master branch may have breaking changes, best practice would be to use a released version in form of a tag (e.g. ?ref=x.y.z)

```terraform

module "route53_association" {
  source = ""

  zone_id    = module.route53_zone.id
  vpc_id     = "vpc-0ced10950faa72baa" 
  vpc_region = "us-east-1"

  providers = {
    aws = aws.network
  }
}

```