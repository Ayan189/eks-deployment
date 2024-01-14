variable "namespace_name" {
  type    = string
  default = "exercise"
}

variable "deployment_name" {
  type    = string
  default = "nginx"
}

variable "service_name" {
  type    = string
  default = "nginx"
}

variable "container_image" {
  type    = string
  default = "nginx"
}

variable "container_port" {
  type    = number
  default = 80
}

variable "service_port" {
  type    = number
  default = 80
}

variable "node_port" {
  type    = number
  default = 30201
}

variable "replicas" {
    type  = number
    default = 2
}

variable "ingress_name" {
    type   = string
    default   = "alb"
}