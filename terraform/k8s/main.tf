provider "kubernetes" {
  config_path = "../kubeconfig.yaml"
}

module "k8s_setup" {
    source = "./k8s_setup"
}