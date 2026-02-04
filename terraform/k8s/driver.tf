resource "helm_release" "driver" {
  name             = "driver"
  namespace        = "default"
  chart            = "${local.workspace_root}/cloudsovereignty-driver/resources/k8s"
  create_namespace = true
  wait             = true

  values = [
    file("${local.workspace_root}/cloudsovereignty-driver/resources/k8s/values.yaml")
  ]

  set = [
    {
      name  = "app.image.tag"
      value = "latest"
    },
    {
      name  = "app.appconfig.GATLING_BASEURL_SUPPLIERDOMAIN"
      value = "http://supplierdomain-service.default.svc.cluster.local"
    },
    {
      name  = "app.appconfig.GATLING_BASEURL_ORDERDOMAIN"
      value = "http://orderdomain-service.default.svc.cluster.local"
    },
    {
      name  = "app.appconfig.GATLING_BASEURL_MANUFACTUREDOMAIN"
      value = "http://manufacturedomain-service.default.svc.cluster.local"
    },
    {
      name  = "app.appconfig.GATLING_NR_USERS"
      value = "5"
      type  = "string"
    },
    {
      name  = "app.appconfig.GATLING_NR_USERS_AT_ONCE"
      value = "2"
      type  = "string"
    },
    {
      name  = "app.appconfig.GATLING_RAMPUP_TIME"
      value = "10"
      type  = "string"
    },
    {
      name  = "app.appconfig.GATLING_MAX_DURATION"
      value = "30"
      type  = "string"
    }
  ]
}
