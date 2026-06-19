output "cluster_id" {
  description = "ID del cluster EKS"
  value       = aws_eks_cluster.this.id
}

output "cluster_name" {
  description = "Nombre del cluster EKS"
  value       = aws_eks_cluster.this.name
}

output "cluster_arn" {
  description = "ARN del cluster EKS"
  value       = aws_eks_cluster.this.arn
}

output "cluster_endpoint" {
  description = "Endpoint del API server del cluster"
  value       = aws_eks_cluster.this.endpoint
}

output "cluster_ca_certificate" {
  description = "Certificate Authority del cluster (base64)"
  value       = aws_eks_cluster.this.certificate_authority[0].data
}

output "cluster_version" {
  description = "Versión de Kubernetes del cluster"
  value       = aws_eks_cluster.this.version
}

output "cluster_security_group_id" {
  description = "ID del security group del control plane"
  value       = aws_security_group.cluster.id
}

output "node_security_group_id" {
  description = "ID del security group de los nodos"
  value       = aws_security_group.nodes.id
}

output "cluster_iam_role_arn" {
  description = "ARN del IAM role del cluster"
  value       = aws_iam_role.cluster.arn
}

output "oidc_provider_arn" {
  description = "ARN del OIDC provider del cluster"
  value       = aws_iam_openid_connect_provider.cluster.arn
}

output "oidc_provider_url" {
  description = "URL del OIDC provider del cluster"
  value       = aws_iam_openid_connect_provider.cluster.url
}
