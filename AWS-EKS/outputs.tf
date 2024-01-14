output "eks_cluster_endpoint" {
  description = "The endpoint for the EKS cluster"
  value       = aws_eks_cluster.example.endpoint
}

output "eks_cluster_ca_certificate" {
  description = "The base64-encoded PEM-encoded certificate authority (CA) certificate for the EKS cluster"
  value       = aws_eks_cluster.example.certificate_authority[0].data
}

output "test_policy_arn" {
  value = aws_iam_role.test_oidc.arn
}
# output "eks_cluster_token" {
#   description = "The kubeconfig for connecting to the EKS cluster"
#   value       = aws_eks_cluster.example.kubeconfig[0].data
# }


