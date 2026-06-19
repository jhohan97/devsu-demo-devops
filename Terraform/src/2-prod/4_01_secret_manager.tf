module "secret_manager_rds_aurora_postgres" {
  source = "../Terraform/modules/secret_manager"

  common_config = {
    name        = var.name
    environment = var.environment
    tags        = var.tags
  }

  secrets_config = {
    secrets_manager = {
      1 = {
        kms_key_id              = module.kms.id
        description             = ""
        recovery_window_in_days = 7
      }
    }

    list_secrets = {
      1 = {
        secret_string = {
          APP_ID     = "dummy"
          API_KEY    = "dummy"
          API_SECRET = "dummy"
        }
      }
    }

    1 = {
      statements = [
        {
          Sid    = "enableInstanceProfile"
          Effect = "Allow"
          Principal = {
            Service = "lambda.amazonaws.com"
          }
          Resource = ["*"]
          Action   = ["sts:AssumeRole"]
        }
      ]
    }

    1 = {
      secret_rotation = [
        {
          rotation_lambda_arn = "" #Aca Pondriamos el ARN de una Lambda que se encargue de rotar los secretos 
          rotation_rules      = 2
        }
      ]
    }
  }
}
