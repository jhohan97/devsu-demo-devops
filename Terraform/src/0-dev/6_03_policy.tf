module "policy_postgresql" {
  source = "git::https://BancoPichinchaEC@dev.azure.com/BancoPichinchaEC/iac-modules/_git/mod-iac-aws//terraform/aws/iam/iam_policy?ref=master"

  common_config = {
    name        = var.name
    environment = var.environment
    tags        = var.tags
  }

  policy_config = {
    "postgresql" = {
      description     = "obtencion de secretos para postgresql ${var.name} 01"
      resource_number = "1"
      statements = [
        {
          Sid      = "1"
          Effect   = "Allow"
          Resource = ["${module.secret_manager_rds_aurora_postgres.arn}"]
          Action = [
            "secretsmanager:GetSecretValue"
          ]
          Condition = {}
        },
        {
          Sid      = "Enabled Proxy"
          Effect   = "Allow"
          Resource = ["*"]
          Action = [
              "rds:DescribeDBProxies",
              "rds:DescribeDBProxyTargets"
          ]
          Condition = {}
        },
        {
          Action = [
            "logs:CreateLogGroup",
            "logs:CreateLogStream",
            "logs:PutLogEvents",
            "logs:DescribeLogStreams"
          ],
          Condition = {},
          Effect    = "Allow",
          Resource = [
            module.cloudwatch_log_group_postgresql.arn
          ],
          Sid = "enableLogs"
        }
      ]
    }
  }
}
