
output "record_name" {
  description = "Zone ARN of Route53 zone"
  value       = values({ for k, v in aws_route53_record.this : k => v.name })
}

output "record_type" {
  description = "Name servers of Route53 zone"
  value       = values({ for k, v in aws_route53_record.this : k => v.type })
}