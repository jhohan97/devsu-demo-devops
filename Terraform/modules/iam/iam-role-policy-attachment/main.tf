resource "aws_iam_role_policy_attachment" "assume_role_policy_attachment" {
  for_each = { for idx, policy_arn in var.policy_arns : idx => policy_arn }

  role       = var.role_name
  policy_arn = each.value
}
