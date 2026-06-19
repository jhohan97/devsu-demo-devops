
### Example of Module Usage

```terraform
module "inline_role_policy" {
  source = ""


  common_config = {
    name      = local.iam_inline_policy_name
    role_name = module.castai_iam_role.name["cluster"]
  }

  policy_config = {
    "castai" = {
      resource_number = var.resource_number
      statements = [
        # Needed to be able launch instance with instance profile.
        {
          Sid      = "PassRoleEC2"
          Effect   = "Allow"
          Resource = ["arn:${local.partition}:iam::${local.account_id}:role/${module.castai_instance_profile_role.name["node"]}"]
          Action   = ["iam:PassRole"]

          Condition = [
            {
              condition_operator = "StringEquals"
              values = [
                {
                  condition_key   = "iam:PassedToService",
                  condition_value = ["ec2.amazonaws.com"]
                }
              ]
            }

          ]
        },
        # # Needed to validate permissions.
        {
          Sid    = "IAMPermissions"
          Effect = "Allow"
          Resource = [
            "arn:${local.partition}:iam::${local.account_id}:role/${module.castai_iam_role.name["cluster"]}",
            "arn:${local.partition}:iam::${local.account_id}:instance-profile/${module.castai_instance_profile.name}"
          ]
          Action = [
            "iam:GetRole",
            "iam:SimulatePrincipalPolicy",
            "iam:GetInstanceProfile"
          ]
          Condition = []

        },
        
        # # Restrict run instance to cluster tag.
        {
          Sid    = "RunInstancesTagRestriction"
          Effect = "Allow"
          Resource = [
            "arn:${local.partition}:ec2:${var.aws_cluster_region}:${local.account_id}:instance/*",
          ]
          Action = [
            "ec2:RunInstances"
          ]
          Condition = [
            {
              condition_operator = "StringEquals"
              values = [
                {
                  condition_key   = "aws:RequestTag/kubernetes.io/cluster/${var.aws_cluster_name}",
                  condition_value = ["owned"]

                },
                {
                  condition_key   = "aws:RequestTag/cast:cluster-id",
                  condition_value = [var.cast_eks_cluster_id]
                }
              ]
            },
          ]
        },
       
      ]
    }
  }
}
