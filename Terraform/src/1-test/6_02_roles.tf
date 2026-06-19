module "role_postgresql" {
  source = "git::https://BancoPichinchaEC@dev.azure.com/BancoPichinchaEC/iac-modules/_git/mod-iac-aws//terraform/aws/iam/iam_roles?ref=master"

  common_config = {
    name        = var.name
    environment = var.environment
    tags        = var.tags
  }

  role_config = {
    "postgresql" = {
      description     = "string"
      resource_number = "01"
      managed_policy_arns = [
        module.policy_postgresql.arn["postgresql"]
      ]
      statements = [
        {
          Sid    = "Statement1"
          Effect = "Allow"
          Principal = {
            Service = "ecs-tasks.amazonaws.com"
          }
          Action = ["sts:AssumeRole"]
        }
      ]
    }
  }
}
