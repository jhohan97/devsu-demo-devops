
output "id" {
  description = "Zone ID of Route53 zone"
  value       = aws_route53_zone.this.zone_id
}

output "arn" {
  description = "Zone ARN of Route53 zone"
   value       = aws_route53_zone.this.arn
}

output "name_servers" {
  description = "Name servers of Route53 zone"
  value       = aws_route53_zone.this.name_servers
}