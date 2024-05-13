resource "helm_release" "neo4j_node1" {
  provider      = helm.node1
  name          = "my-neo4j"
  chart         = "neo4j"
  repository    = "https://helm.neo4j.com/neo4j"
  namespace     = "devops"
  set {
    name  = "neo4j.name"
    value = "my-neo4j"
  }

  set {
    name  = "volumes.data.mode"
    value = "defaultStorageClass"
  }
  wait = false
}

resource "helm_release" "neo4j_node2" {
  provider      = helm.node2
  repository    = "https://helm.neo4j.com/neo4j"
  name          = "my-neo4j"
  chart         = "neo4j"
  namespace     = "devops"
  set {
    name  = "neo4j.name"
    value = "my-neo4j"
  }

  set {
    name  = "volumes.data.mode"
    value = "defaultStorageClass"
  }
  wait = false
}

resource "helm_release" "temp2_node1" {
  provider      = helm.node1
  name          = "temporalio2"
  chart         = "temporal"
  repository    = "https://armory.jfrog.io/artifactory/charts/"
  namespace     = "devops"

  set {
    name  = "elasticsearch.enabled"
    value = "false"  // Example name that conforms to Kubernetes naming conventions
  }

  set {
    name  = "grafana.enabled"
    value = "false"  // Example name that conforms to Kubernetes naming conventions
  }

  set {
    name  = "prometheus.enabled"
    value = "false"  // Example name that conforms to Kubernetes naming conventions
  }

  set {
    name  = "server.persistence.enabled"
    value = "false"  // Example name that conforms to Kubernetes naming conventions
  }

  set {
    name  = "cassandra.config.cluster_size"
    value = "1"  // Example name that conforms to Kubernetes naming conventions
  }
  wait = false
}






resource "helm_release" "temp2_node2" {
  provider      = helm.node2
  name          = "temporalio2"
  chart         = "temporal"
  repository    = "https://armory.jfrog.io/artifactory/charts/"
  namespace     = "devops"

  set {
    name  = "elasticsearch.enabled"
    value = "false"  // Example name that conforms to Kubernetes naming conventions
  }

  set {
    name  = "grafana.enabled"
    value = "false"  // Example name that conforms to Kubernetes naming conventions
  }

  set {
    name  = "prometheus.enabled"
    value = "false"  // Example name that conforms to Kubernetes naming conventions
  }

  set {
    name  = "server.persistence.enabled"
    value = "false"  // Example name that conforms to Kubernetes naming conventions
  }

  set {
    name  = "cassandra.config.cluster_size"
    value = "1"  // Example name that conforms to Kubernetes naming conventions
  }
  wait = false
}
