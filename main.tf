module "docker_aws" {
  source             = "./Docker-Module"
  docker_image_name  = "registry-1.docker.io/a4ayan/hello-world:1"
  keep_remotely_true = true
  dockerfile_path    = "Dockerfile"
}

module "aws_vpc" {
  source                               = "./AWS-VPC"
  vpc_cidr_block                       = "192.168.0.0/16"
  vpc_instance_tenancy                 = "default"
  vpc_enable_dns_support               = true
  vpc_enable_dns_hostnames             = true
  vpc_assign_generated_ipv6_cidr_block = false
  vpc_tags = {
    Name = "main"
  }
  internet_gateway_tags = {
    Name = "main"
  }
  subnet_cidr_public_1  = "192.168.0.0/18"
  subnet_cidr_public_2  = "192.168.64.0/18"
  subnet_cidr_private_1 = "192.168.128.0/18"
  subnet_cidr_private_2 = "192.168.192.0/18"

  subnet_availability_zone_public_1  = "us-east-1a"
  subnet_availability_zone_public_2  = "us-east-1b"
  subnet_availability_zone_private_1 = "us-east-1a"
  subnet_availability_zone_private_2 = "us-east-1b"

  subnet_map_public_ip_on_launch = true

  subnet_pub_tags = {
    "kubernetes.io/cluster/${var.eks_cluster_name}" = "shared"
    "kubernetes.io/cluster/eks"                     = "shared"
    "kubernetes.io/role/elb"                        = 1
  }
  subnet_pri_tags = {
    "kubernetes.io/cluster/${var.eks_cluster_name}" = "shared"
    "kubernetes.io/cluster/eks"                     = "shared"
    "kubernetes.io/role/elb"                        = 1
  }
  nat_gateway_tags_1 = {
    "Name" = "CustomNatGateway1"
  }

  nat_gateway_tags_2 = {
    "Name" = "CustomNatGateway2"
  }

  public_route_cidr  = "0.0.0.0/0"
  private_route_cidr = "0.0.0.0/0"


}

module "aws_eks" {

  source                        = "./AWS-EKS"
  eks_cluster_name              = var.eks_cluster_name
  eks_node_group_name           = "example_ng_1"
  eks_node_group_instance_types = ["t3.small"]
  eks_node_group_disk_size      = 20
  eks_node_group_ami_type       = "AL2_x86_64"
  eks_node_group_capacity_type  = "SPOT"

  eks_node_group_desired_size    = 1
  eks_node_group_max_size        = 1
  eks_node_group_min_size        = 1
  eks_node_group_max_unavailable = 1

  eks_cluster_subnets = [
    module.aws_vpc.private_subnet_ids[0],
    module.aws_vpc.private_subnet_ids[1]
  ]

}

module "alb_controller" {
  source                           = "./AWS-ALB"
  cluster_name                     = var.eks_cluster_name
  cluster_identity_oidc_issuer     = data.aws_eks_cluster.example.identity.0.oidc.0.issuer
  cluster_identity_oidc_issuer_arn = data.aws_iam_openid_connect_provider.oidc_provider.arn
  aws_region                       = var.aws_region
}

module "deployment" {
  source          = "./Deployment"
  namespace_name  = "exercise"
  deployment_name = "nginx"
  service_name    = "nginx"
  ingress_name    = "ingress"
  service_port    = 80
  container_image = module.docker_aws.docker_image_name
  container_port  = 80
  node_port       = 30201
  replicas        = 2
}