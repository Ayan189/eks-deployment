output "docker_image_id" {
  value = module.docker_aws.docker_image_id
}

output "docker_image_name" {
  value = module.docker_aws.docker_image_name
}


output "vpc_id" {
  value = module.aws_vpc.vpc_id
}

output "public_subnet_id" {
  value = module.aws_vpc.public_subnet_ids
}

output "private_subnet_id" {
  value = module.aws_vpc.private_subnet_ids
}

output "nategateway" {
  value = module.aws_vpc.nat_gateway_ids
}

output "public_rt" {
  value = module.aws_vpc.public_route_table_id
}

output "private_rt" {
  value = module.aws_vpc.private_route_table_ids
}

# output "eks_cluster_endpoint" {
#   value = module.aws_eks.eks_cluster_endpoint
# }

# output "eks_cluster_ca_certificate" {
#   description = "The base64-encoded PEM-encoded certificate authority (CA) certificate for the EKS cluster"
#   value       = module.aws_eks.eks_cluster_ca_certificate
# }

# output "load_balancer_hostname" {
#   value = module.deployment.load_balancer_hostname
# }