output "k8s_kubeconfig" {
    value = stackit_ske_kubeconfig.example.kube_config
    sensitive = true
}