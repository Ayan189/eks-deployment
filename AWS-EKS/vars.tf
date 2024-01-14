variable "eks_cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
  default     = "example"
}

variable "eks_node_group_name" {
  description = "The name of the EKS node group"
  type        = string
  default     = "example_ng_1"
}

variable "eks_node_group_instance_types" {
  description = "List of EC2 instance types for the EKS node group"
  type        = list(string)
  default     = ["t3.small"]
}

variable "eks_node_group_disk_size" {
  description = "The size of the EKS node group's EBS volumes in GiB"
  type        = number
  default     = 20
}

variable "eks_node_group_ami_type" {
  description = "The type of Amazon Machine Image (AMI) to use for the EKS node group"
  type        = string
  default     = "AL2_x86_64"
}

variable "eks_node_group_capacity_type" {
  description = "The capacity type of the EKS node group (ON_DEMAND or SPOT)"
  type        = string
  default     = "SPOT"
}

variable "eks_node_group_desired_size" {
  description = "Desired number of worker nodes in the EKS node group"
  type        = number
  default     = 1
}

variable "eks_node_group_max_size" {
  description = "Maximum number of worker nodes in the EKS node group"
  type        = number
  default     = 1
}

variable "eks_node_group_min_size" {
  description = "Minimum number of worker nodes in the EKS node group"
  type        = number
  default     = 1
}

variable "eks_node_group_max_unavailable" {
  description = "Maximum number of unavailable nodes during updates in the EKS node group"
  type        = number
  default     = 1
}

variable "eks_cluster_subnets" {
  description = "List of subnet IDs for the EKS cluster"
  type        = list(string)
  default     = []
}
