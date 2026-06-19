
### Example of how to call the module

IMPORTANT: We periodically release versions for the components. Since, master branch may have breaking changes, best practice would be to use a released version in form of a tag (e.g. ?ref=x.y.z)

```terraform

module "cw" {
  source = ""

  common_config = {
    name        = var.name
    event       = 1
    environment = var.environment
    tags        = var.tags
  }

  cw_config = {
    arn           = module.lambda.arn
    target_id     = "Lambda funtion target"    
    description   = "Lambda funtion target"

    event_pattern = {
      source = ["aws.ecr"]
      detail_type = ["ECR Image Action"]

      detail = {
        action-type  = ["push"]
      }
    }
  }
}

```
