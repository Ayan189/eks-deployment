variable "docker_image_name" {
  description = "The name of the Docker image to build"
  type        = string
  default       = ""
}

variable "dockerfile_path" {
  description = "The dockerfile path"
  type        = string
  default      = ""
}

variable "keep_remotely_true" {
  description = "keep remotely true"
  type        = bool
  default     = true
}
