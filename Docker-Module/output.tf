output "docker_image_id" {
  description = "The ID of the Docker image"
  value       = docker_image.helloworldimage.id
}

output "docker_image_name" {
  value       = docker_image.helloworldimage.name
}
