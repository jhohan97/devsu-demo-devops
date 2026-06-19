
################################################################################
# EKS Cluster
################################################################################
resource "aws_eks_cluster" "this" {
  name     = var.cluster_name
  version  = var.cluster_version
  role_arn = aws_iam_role.cluster.arn

  vpc_config {
    subnet_ids              = var.subnet_ids
    security_group_ids      = [aws_security_group.cluster.id]
    endpoint_private_access = var.endpoint_private_access
    endpoint_public_access  = var.endpoint_public_access
    public_access_cidrs     = var.public_access_cidrs
  }

  enabled_cluster_log_types = var.cluster_log_types

  dynamic "encryption_config" {
    for_each = var.cluster_encryption_key_arn != null ? [1] : []
    content {
      provider {
        key_arn = var.cluster_encryption_key_arn
      }
      resources = ["secrets"]
    }
  }

  tags = merge(var.tags, {
    Name = var.cluster_name
  })

  depends_on = [
    aws_iam_role_policy_attachment.cluster_AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.cluster_AmazonEKSVPCResourceController,
  ]
}

################################################################################
# OIDC Provider (requerido para IRSA)
################################################################################
data "tls_certificate" "cluster" {
  url = aws_eks_cluster.this.identity[0].oidc[0].issuer
}

resource "aws_iam_openid_connect_provider" "cluster" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.cluster.certificates[0].sha1_fingerprint]
  url             = aws_eks_cluster.this.identity[0].oidc[0].issuer

  tags = merge(var.tags, {
    Name = "${var.cluster_name}-oidc"
  })
}

################################################################################
# aws-auth ConfigMap
################################################################################
resource "kubernetes_config_map_v1_data" "aws_auth" {
  count = length(var.aws_auth_roles) > 0 || length(var.aws_auth_users) > 0 ? 1 : 0

  metadata {
    name      = "aws-auth"
    namespace = "kube-system"
  }

  data = {
    mapRoles = yamlencode(concat(
      [for role in var.aws_auth_roles : {
        rolearn  = role.rolearn
        username = role.username
        groups   = role.groups
      }],
    ))
    mapUsers = yamlencode([for user in var.aws_auth_users : {
      userarn  = user.userarn
      username = user.username
      groups   = user.groups
    }])
  }

  force = true
}
