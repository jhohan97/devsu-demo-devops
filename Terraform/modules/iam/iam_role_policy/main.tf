resource "aws_iam_role_policy" "inline_role_policy" {

  for_each = var.policy_config

  name = var.common_config.name
  role = var.common_config.role_name

  policy = jsonencode({
    Version = each.value.iam_version
    Statement = [
      for statement in each.value.statements : {
        Sid      = statement.Sid
        Effect   = statement.Effect
        Action   = statement.Action
        Resource = statement.Resource
        Condition = length(statement.Condition) > 0 ? {
          for condition in statement.Condition : condition.condition_operator => {
            for item in condition.values : item.condition_key => item.condition_value
          }
        } : {}
    }]
  })
}
