
module "subnet_public" {
  source = "/Terraform/modules/Networking/subnet"

  common_config = {
    name            = var.name
    environment     = var.environment
    resource_number = 01
    tags            = var.tags
  }

  subnet_config {
    type                    = "public"
    vpc_id                  = module.vpc_config.vpc_id
    cidr_block              = ["10.0.1.0/24"]
    availability_zone       = ["us-east-1a"]
    map_public_ip_on_launch = false
  }
}

module "subnet_public" {
  source = "/Terraform/modules/Networking/subnet"

  common_config = {
    name            = var.name
    environment     = var.environment
    resource_number = 02
    tags            = var.tags
  }

  subnet_config {
    type                    = "public"
    vpc_id                  = module.vpc_config.vpc_id
    cidr_block              = ["10.0.2.0/24"]
    availability_zone       = ["us-east-1b"]
    map_public_ip_on_launch = false
  }
}

module "subnet_private" {
  source = "/Terraform/modules/Networking/subnet"

  common_config = {
    name            = var.name
    environment     = var.environment
    resource_number = 01
    tags            = var.tags
  }

  subnet_config {
    type                    = "private"
    vpc_id                  = module.vpc_config.vpc_id
    cidr_block              = ["10.0.3.0/24"]
    availability_zone       = ["us-east-1a"]
    map_public_ip_on_launch = false
  }
}

module "subnet_private" {
  source = "/Terraform/modules/Networking/subnet"

  common_config = {
    name            = var.name
    environment     = var.environment
    resource_number = 02
    tags            = var.tags
  }

  subnet_config {
    type                    = "private"
    vpc_id                  = module.vpc_config.vpc_id
    cidr_block              = ["10.0.4.0/24"]
    availability_zone       = ["us-east-1a"]
    map_public_ip_on_launch = false
  }
}

module "subnet_private" {
  source = "/Terraform/modules/Networking/subnet"

  common_config = {
    name            = var.name
    environment     = var.environment
    resource_number = 03
    tags            = var.tags
  }

  subnet_config {
    type                    = "private"
    vpc_id                  = module.vpc_config.vpc_id
    cidr_block              = ["10.0.5.0/24"]
    availability_zone       = ["us-east-1b"]
    map_public_ip_on_launch = false
  }
}

module "subnet_private" {
  source = "/Terraform/modules/Networking/subnet"

  common_config = {
    name            = var.name
    environment     = var.environment
    resource_number = 04
    tags            = var.tags
  }

  subnet_config {
    type                    = "private"
    vpc_id                  = module.vpc_config.vpc_id
    cidr_block              = ["10.0.6.0/24"]
    availability_zone       = ["us-east-1b"]
    map_public_ip_on_launch = false
  }
}

module "subnet_protected" {
  source = "/Terraform/modules/Networking/subnet"

  common_config = {
    name            = var.name
    environment     = var.environment
    resource_number = 01
    tags            = var.tags
  }

  subnet_config {
    type                    = "protected"
    vpc_id                  = module.vpc_config.vpc_id
    cidr_block              = ["10.0.7.0/24"]
    availability_zone       = ["us-east-1a"]
    map_public_ip_on_launch = false
  }
}

module "subnet_protected" {
  source = "/Terraform/modules/Networking/subnet"

  common_config = {
    name            = var.name
    environment     = var.environment
    resource_number = 02
    tags            = var.tags
  }

  subnet_config {
    type                    = "protected"
    vpc_id                  = module.vpc_config.vpc_id
    cidr_block              = ["10.0.8.0/24"]
    availability_zone       = ["us-east-1a"]
    map_public_ip_on_launch = false
  }
}

module "subnet_protected" {
  source = "/Terraform/modules/Networking/subnet"

  common_config = {
    name            = var.name
    environment     = var.environment
    resource_number = 03
    tags            = var.tags
  }

  subnet_config {
    type                    = "protected"
    vpc_id                  = module.vpc_config.vpc_id
    cidr_block              = ["10.0.9.0/24"]
    availability_zone       = ["us-east-1b"]
    map_public_ip_on_launch = false
  }
}

module "subnet_protected" {
  source = "/Terraform/modules/Networking/subnet"

  common_config = {
    name            = var.name
    environment     = var.environment
    resource_number = 04
    tags            = var.tags
  }

  subnet_config {
    type                    = "protected"
    vpc_id                  = module.vpc_config.vpc_id
    cidr_block              = ["10.0.10.0/24"]
    availability_zone       = ["us-east-1b"]
    map_public_ip_on_launch = false
  }
}
