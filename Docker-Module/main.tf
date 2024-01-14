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
  }
}



resource "docker_image" "helloworldimage" {
  name = var.docker_image_name

  build {
    context = "."
    dockerfile = var.dockerfile_path
    platform  = "linux/amd64" 
  }
  
}

resource "docker_registry_image" "name" {
  name          = docker_image.helloworldimage.name
  keep_remotely = var.keep_remotely_true
}