resource "kubernetes_namespace" "devops_node1" {
  provider = kubernetes.node1

  metadata {
    name = "devops"
  }
}

resource "kubernetes_namespace" "devops_node2" {
  provider = kubernetes.node2
  metadata {
    name = "devops"
  }
}
