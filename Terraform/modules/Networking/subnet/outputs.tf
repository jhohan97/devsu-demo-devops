
output "id" {
  description = "ID subnet"
  value = aws_subnet.this[*].id
}

output "ids" {
  description = "ID subnet"
  value = aws_subnet.this[*].id
}

output "subnets" {
  value = aws_subnet.this
}

output "subnet_ids_and_zone" {
  value = [
    for idx, subnet_id in aws_subnet.this[*].id : {
      subnet_id         = subnet_id
      availability_zone = aws_subnet.this[idx].availability_zone
    }
  ]
}