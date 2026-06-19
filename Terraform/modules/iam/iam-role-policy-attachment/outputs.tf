output "attached_policies" {
  description = "List of IAM policy ARNs attached to the role"
  value       = aws_iam_role_policy_attachment.assume_role_policy_attachment[*]
}
