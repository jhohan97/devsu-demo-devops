

### Example of Module Usage

```terraform

module "iam_policy_external_dns_public" {
  source = ""

  common_config = {
    name        = "pub-${var.name}"
    tags        = var.tags
    environment = var.environment
  }

  policy_config = {
    "dns" = {
      resource_number = var.resource_number
      description     = "iam policy ${var.name} external-dns public"
      statements = [
        {
          Sid       = "1"
          Effect    = "Allow"
          Resource  = var.route53_zone_public_arn
          Action    = ["route53:ChangeResourceRecordSets"]
          Condition = {}
        },
        {
          Sid      = "2"
          Effect   = "Allow"
          Resource = ["*"]
          Action = [
            "route53:ListHostedZones",
            "route53:ListResourceRecordSets"
          ]
          Condition = {}
        }

      ]
    }
  }
}
