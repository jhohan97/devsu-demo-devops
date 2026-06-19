
#-----------------------------------------------
# AWS IAM Policy appFlow
#-----------------------------------------------
module "iam_policy_lb" {
  source = "../../modules/iam/iam_policy"

  common_config = {
    name        = var.name
    environment = var.environment
    tags        = var.tags
  }

  policy_config = {
    lb = {
      description     = "Enable ecr ${var.name} 01"
      resource_number = "1"
      statements = [
        {
          Sid    = "lbPermissions"
          Effect = "Allow"
          Resource = ["*"]
          Action = [
            "ec2:DescribeSubnets",
            "ec2:DescribeSecurityGroups",
            "elasticloadbalancing:DescribeTargetGroups",
            "elasticloadbalancing:DescribeTargetHealth",
            "elasticloadbalancing:RegisterTargets",
            "elasticloadbalancing:DeregisterTargets"
          ]
          Condition = {}
        },
        {
          Sid    = "acceso a certificados"
          Effect = "Allow"
          Resource = ["arn:aws:acm:region:account-id:certificate/uuid-del-certificado"]
          Action = [
            "acm:DescribeCertificate",
            "acm:GetCertificate",
            "acm:ListCertificates"
          ]
          Condition = {}
        },
        {
          Sid    = "acceso al WAF"
          Effect = "Allow"
          Resource = ["*"]
          Action = [
            "wafv2:AssociateWebACL",
            "wafv2:DisassociateWebACL",
            "wafv2:GetWebACL"
          ]
          Condition = {}
        },
      ]
    }
  }
}

data "aws_iam_policy_document" "cluster_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["eks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "cluster" {
  name               = "${var.cluster_name}-cluster-role"
  assume_role_policy = data.aws_iam_policy_document.cluster_assume_role.json

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "cluster_AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.cluster.name
}

resource "aws_iam_role_policy_attachment" "cluster_AmazonEKSVPCResourceController" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  role       = aws_iam_role.cluster.name
}