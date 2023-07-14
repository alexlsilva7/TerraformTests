resource "kubernetes_deployment" "Django-API" {
  metadata {
    name = "django-api"
    labels = {
      app = "django-api"
    }
  }
  spec {
    replicas = 3
    selector {
      match_labels = {
        app = "django-api"
      }
    }
    template {
      metadata { 
        labels = {
          app = "django-api"
        }
      }
      spec {
        container {
          image = "${data.aws_ecr_repository.django-api.repository_url}/producao:v1"
          name = "django-api"
          port {
            container_port = 8000
          }

          resources {
            limits {
              cpu = "0.5"
              memory = "512Mi"
            }
            requests {
              cpu = "100m"
              memory = "128Mi"
            }
          }

          liveness_probe {
            http_get {
              path = "/clientes/"
              port = 8000
            }
            
            initial_delay_seconds = 5
            period_seconds = 5
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "LoadBalancer" {
  metadata {
    name = "django-api"
  }
  spec {
    selector = {
      app = "django-api"
    }
    port {
      port = 8000
      target_port = 8000
    }
    type = "LoadBalancer"
  }
}

data "kubernetes_service" "DNSname" {
  metadata {
    name = "django-api"
  }
}

output "URL" {
  value = data.kubernetes_service.DNSname.status
}