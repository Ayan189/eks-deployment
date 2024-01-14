variable "eks_cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
  default     = "example"
}

variable "aws_region" {
  description = "region name"
  type        = string
  default     = "us-east-1"
}

variable "profile_name" {
  description = "profile name"
  type        = string
  default     = "terraform_project"
}