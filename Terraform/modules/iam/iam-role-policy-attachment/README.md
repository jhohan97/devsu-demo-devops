
## Usage

```hcl
module "iam_role_policy_attachment" {
  source = ""

  role_name   = "example_role"
  policy_arns = [
    "arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess",
    "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess",
  ]
}
