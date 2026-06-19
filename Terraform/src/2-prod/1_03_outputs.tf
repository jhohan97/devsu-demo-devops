## Terraform Outputs para los recursos que se requieran, se pueden añadir los necesarios

output "id" {
  description = "Id VPC"
  value = vpc_config.this.id
}

output "vpc" {
  description = "All outputs"
  value = vpc_config.this
}