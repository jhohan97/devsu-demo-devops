Ejemplo de uso 

module "ecr" {
  source = "../../modules/ecr/repository"

  common_config = {
    name            = var.name
    environment     = var.environment
    resource_number = 01
  }
  kms_key = module.kms.kms_key_id
  tags    = var.tags
}