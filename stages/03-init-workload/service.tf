resource "kubernetes_service" "hello-world" {
  metadata {
    name = "hello-world"
    namespace = kubernetes_namespace.sca.metadata[0].name
  }

  spec {
    selector = {
      app = "hello-world"
    }

    port {
      name       = "http"
      port       = 443
      target_port = 443
    }

    type = "LoadBalancer"
  }
  depends_on = [kubernetes_deployment.hello_world_deployment]
}