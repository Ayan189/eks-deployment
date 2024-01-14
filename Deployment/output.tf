output "deployment_name" {
  value = kubernetes_deployment.test.metadata.0.name
}

output "service_name" {
  value = kubernetes_service.test.metadata.0.name
}

output "namespace_name" {
  value = kubernetes_namespace.test.metadata.0.name
}

output "load_balancer_hostname" {
  value = kubernetes_ingress_v1.example.status.0.load_balancer.0.ingress.0.hostname
}