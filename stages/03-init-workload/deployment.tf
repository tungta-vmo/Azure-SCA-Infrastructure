resource "kubernetes_deployment" "hello_world_deployment" {
  metadata {
    name   = "hello-world-deployment"
    labels = {
      app = "hello-world"
    }
    namespace = kubernetes_namespace.sca.metadata[0].name
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "hello-world"
      }
    }

    template {
      metadata {
        labels = {
          app = "hello-world"
        }
      }

      spec {
        container {
          name  = "hello-world"
          image = "nginx"
          port {
            container_port = 80
          }
        }
      }
    }
  }
}