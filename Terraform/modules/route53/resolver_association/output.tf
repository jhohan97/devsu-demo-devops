
output "id" {
  description = "Route53 resolver association id"
  value       = [for resolver in aws_route53_resolver_rule_association.this: resolver]
}