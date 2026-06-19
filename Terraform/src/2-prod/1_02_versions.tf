## configuracion de Terraform para el provider de AWS, se pueden añadir otros providers segun se requiera

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.64.0"
    }
  }
}

provider "aws" {
  region = var.region
}