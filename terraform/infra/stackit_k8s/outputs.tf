output "k8s_kubeconfig" {
    value = stackit_ske_kubeconfig.cloudsovereignty_cluster_kubeconfig.kube_config
    sensitive = true
}