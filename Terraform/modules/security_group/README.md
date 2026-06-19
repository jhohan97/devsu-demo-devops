

### Example of how to call the module

IMPORTANT: We periodically release versions for the components. Since, master branch may have breaking changes, best practice would be to use a released version in form of a tag (e.g. ?ref=x.y.z)

```terraform

module "security_group" {
  source = ""

  name   = var.name
  vpc_id = module.vpc.vpc_id

  rules = {
    ingress = {
      ddb = {
        cidr_blocks = ["0.0.0.0/0"]
        to_port     = 22
        from_port   = 22
        protocol    = "tcp"
        description = "Permite el funcionamiento del sensor de Tenable en ambiente no productivo"
      }
    }

    egress = {
      all_egress = {
        cidr_blocks = ["0.0.0.0/0"]
        to_port     = 0
        from_port   = 0
        protocol    = "-1"
        description = "All egress"
      }
    }
  }

  tags = var.tags
}

```
