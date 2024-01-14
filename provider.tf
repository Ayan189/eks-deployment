terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.0.2"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.25.2"
    }
  }
  backend "s3" {
    bucket         = "my-statefile-terraform"
    key            = "state/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "backend-terraform"
    profile        = "terraform_project"
  }

}

provider "docker" {
  #   host = "unix:///var/run/docker.sock"
  registry_auth {
    address  = "registry-1.docker.io"
    username = jsondecode(data.aws_secretsmanager_secret_version.secret-version.secret_string)["user_name"]
    password = jsondecode(data.aws_secretsmanager_secret_version.secret-version.secret_string)["password"]
  }

}

provider "aws" {
  # Your AWS provider configuration
  region  = "us-east-1"
  profile = "terraform_project"

}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.example.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.example.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.example.token
}

provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.example.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.example.certificate_authority[0].data)
    token                  = data.aws_eks_cluster_auth.example.token
  }
}


