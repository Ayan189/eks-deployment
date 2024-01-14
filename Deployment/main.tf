resource "kubernetes_namespace" "test" {
  metadata {
    name = var.namespace_name
  }
}

resource "kubernetes_deployment" "test" {
  metadata {
    name      = var.deployment_name
    namespace = kubernetes_namespace.test.metadata.0.name
  }

  spec {
    replicas = var.replicas

    selector {
      match_labels = {
        app = var.deployment_name
      }
    }

    template {
      metadata {
        labels = {
          app = var.deployment_name
        }
      }

      spec {
        container {
          image = var.container_image
          name  = var.deployment_name

          port {
            container_port = var.container_port
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "test" {
  metadata {
    name      = var.service_name
    namespace = kubernetes_namespace.test.metadata.0.name
  }

  spec {
    selector = {
      app = kubernetes_deployment.test.spec.0.template.0.metadata.0.labels.app
    }

    type = "NodePort"

    port {
      node_port   = var.node_port
      port        = var.service_port
      target_port = var.container_port
    }
  }
}


resource "kubernetes_ingress_v1" "example" {
   metadata {
      name        = var.ingress_name
    namespace = kubernetes_namespace.test.metadata.0.name
      annotations = {
      "kubernetes.io/ingress.class" = "alb"
      "alb.ingress.kubernetes.io/scheme" = "internet-facing"
      }
   }
   spec {
      rule {
        http {
         path {
           path = "/"
           backend {
             service {
               name = var.service_name
               port {
                 number = var.service_port
               }
             }
           }
        }
      }
    }
  }
}

