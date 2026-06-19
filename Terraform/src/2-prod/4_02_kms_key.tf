module "kms" {
  source = "../infra/Terraform/modules/kms"

  name = var.name
  role = module.iam_role_01.arn["middleware"]

  statements = [
    {
      Sid    = "Enable IAM User Permissions"
      Effect = "Allow"
      Principal = {
        AWS = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
      }
      Resource = ["*"]
      Action   = ["kms:*"]
    },
    {
      Sid    = "Allow key admin"
      Effect = "Allow"
      Principal = {
        Service ="ecr.amazonaws.com"
      }
      Resource = ["*"]
      Action = [
        "kms:Create*",
        "kms:Describe*",
        "kms:Enable*",
        "kms:List*",
        "kms:Put*",
        "kms:Update*",
        "kms:Revoke*",
        "kms:Disable*",
        "kms:Get*",
        "kms:Delete*",
        "kms:ScheduleKeyDeletion",
        "kms:CancelKeyDeletion"
      ]
    },
    {
      Sid    = "Allow use of the key"
      Effect = "Allow"
      Principal = {
        Service =  "ecr.amazonaws.com"
      },
      Action = [
        "kms:Encrypt",
        "kms:Decrypt",
        "kms:ReEncrypt*",
        "kms:GenerateDataKey*",
        "kms:DescribeKey",
        "kms:Update*"
      ],
      Resource = ["*"]
    }
  ]

  tags = var.tags
}