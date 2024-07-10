Terraform Module: One-Click AWS Infrastructure Deployment
This Terraform module provides a one-click solution to set up an AWS infrastructure including VPC, EKS, and ALB. It builds a Docker image from your application code, pushes it to Docker Hub, and deploys it using Helm charts. The module outputs the end URL to access the deployed application.

Contents
Prerequisites
Usage
Module Structure
Inputs
Outputs
License
Prerequisites
Terraform installed on your local machine.
AWS account and credentials configured.
Docker installed for building and pushing the Docker image.
Docker Hub account for storing the Docker image.
Usage
To use this module, include it in your Terraform configuration:

hcl
Copy code
module "aws_infrastructure" {
  source = "<path-to-your-module>"

  # Pass any required variables here
}
Initialize Terraform and apply the configuration:

sh
Copy code
terraform init
terraform apply
This command will:

Build the Docker image from the application code.
Push the Docker image to Docker Hub.
Create an AWS VPC.
Create an AWS EKS cluster.
Install EKS add-ons and the AWS Load Balancer Controller.
Deploy the pod using the Docker Hub image.
Connect the pod to the service and ingress.
Output the URL to access the application.
Module Structure
The module is organized as follows:

AWS-VPC/: Contains Terraform configuration files for setting up the Virtual Private Cloud (VPC).
AWS-EKS/: Contains Terraform configuration files for setting up the Elastic Kubernetes Service (EKS) cluster.
AWS-ALB/: Contains Terraform configuration files for setting up the Application Load Balancer (ALB).
Deployment/: Contains Helm charts and related configuration for deploying the application to the EKS cluster.
Docker-Module/: Contains Dockerfile and related files for building the Docker image from the application code.
.gitignore: Specifies files and directories to be ignored by git.
Dockerfile: Dockerfile for building the Docker image from the application code.
data.tf: Terraform data sources configuration file.
index.html: Sample index.html file for the application.
Screenshot from 2024-01-15 23-20-03.png: Screenshot image file.
Inputs
Specify any input variables your module requires in this section. Example:

hcl
Copy code
variable "docker_image_name" {
  description = "Name of the Docker image"
  type        = string
}

variable "dockerhub_username" {
  description = "Docker Hub username"
  type        = string
}

variable "dockerhub_password" {
  description = "Docker Hub password"
  type        = string
  sensitive   = true
}

# Add more variables as needed
Outputs
Specify any output values your module provides in this section. Example:

hcl
Copy code
output "application_url" {
  description = "URL to access the deployed application"
  value       = aws_lb.this.dns_name
}
License
This project is licensed under the MIT License.

