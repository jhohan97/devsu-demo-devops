## configuracion de Terraform para el backend de AWS, se pueden añadir otros backends segun se requiera, esto es para almacenar el estado

terraform {
  backend "aws" {
    bucket = "devsu-terraform-state"
    key    = "0-dev/terraform.tfstate"
    region = var.region
  }
}