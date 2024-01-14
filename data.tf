data "aws_secretsmanager_secret" "by-name" {
  name = "docker"
}

data "aws_secretsmanager_secret_version" "secret-version" {
  secret_id = data.aws_secretsmanager_secret.by-name.id
}

data "aws_eks_cluster" "example" {
  name = "example"
}

data "aws_eks_cluster_auth" "example" {
  name = "example"
}

data "aws_iam_openid_connect_provider" "oidc_provider" {
  url = data.aws_eks_cluster.example.identity.0.oidc.0.issuer
}