provider "kubernetes" {
  alias          = "node1"
  config_path    = "../node1_kubeconfig"
}

provider "kubernetes" {
  alias          = "node2"
  config_path    = "../node2_kubeconfig"
}

provider "helm" {
  alias          = "node1"
  kubernetes {
    config_path    = "../node1_kubeconfig"
  }
}


provider "helm" {
  alias          = "node2"
  kubernetes {
    config_path    = "../node2_kubeconfig"
  }
}