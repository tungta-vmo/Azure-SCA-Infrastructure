resource "kubernetes_namespace" "sca" {
  metadata {
    name = "sca"
  }
}