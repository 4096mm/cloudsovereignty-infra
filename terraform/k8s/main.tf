provider "kubernetes" {
  config_path = "../kubeconfig.yaml"
}

provider "helm" {
  kubernetes = {
    config_path = "../kubeconfig.yaml"
  }
}

data "terraform_remote_state" "infra" {
  backend = "local"
  config = {
    path = "../infra/terraform.tfstate"
  }
}

resource "helm_release" "manufacturer_domain" {
  name             = "manufacturerdomain"
  namespace        = "default"
  chart            = "../../../cloudsovereignty-manufacturerdomain/resources/k8s" # path to chart inside repo
  create_namespace = true
  wait             = true

  values = [
    file("../../../cloudsovereignty-manufacturerdomain/resources/k8s/values.yaml")
  ]

  set_sensitive = [
    {
      name  = "app.dbconfig.user"
      value = data.terraform_remote_state.infra.outputs.manufacturer_dbuser
    },
    {
      name  = "app.dbconfig.password"
      value = data.terraform_remote_state.infra.outputs.manufacturer_dbpassword
    }
  ]

  set = [
    {
      name  = "app.image.tag"
      value = "latest"
    },
    {
      name  = "app.dbconfig.host"
      value = data.terraform_remote_state.infra.outputs.dbhost
    },
    {
      name  = "app.dbconfig.port"
      value = data.terraform_remote_state.infra.outputs.dbport
      type  = "string" # needed to ensure port is treated as string
    },
    {
      name  = "app.dbconfig.schema"
      value = "public"
    },
    {
      name  = "app.dbconfig.name"
      value = data.terraform_remote_state.infra.outputs.manufacturer_dbname
    }
  ]
}

resource "helm_release" "supplier_domain" {
  name             = "supplierdomain"
  namespace        = "default"
  chart            = "../../../cloudsovereignty-supplierdomain/resources/k8s"
  create_namespace = true
  wait             = true

  values = [
    file("../../../cloudsovereignty-supplierdomain/resources/k8s/values.yaml")
  ]

  set_sensitive = [
    {
      name  = "app.dbconfig.user"
      value = data.terraform_remote_state.infra.outputs.supplier_dbuser
    },
    {
      name  = "app.dbconfig.password"
      value = data.terraform_remote_state.infra.outputs.supplier_dbpassword
    }
  ]

  set = [
    {
      name  = "app.image.tag"
      value = "latest"
    },
    {
      name  = "app.dbconfig.host"
      value = data.terraform_remote_state.infra.outputs.dbhost
    },
    {
      name  = "app.dbconfig.port"
      value = data.terraform_remote_state.infra.outputs.dbport
      type  = "string" # needed to ensure port is treated as string
    },
    {
      name  = "app.dbconfig.schema"
      value = "public"
    },
    {
      name  = "app.dbconfig.name"
      value = data.terraform_remote_state.infra.outputs.supplier_dbname
    }
  ]
}

resource "helm_release" "order_domain" {
  name             = "orderdomain"
  namespace        = "default"
  chart            = "../../../cloudsovereignty-orderdomain/resources/k8s"
  create_namespace = true
  wait             = true

  values = [
    file("../../../cloudsovereignty-orderdomain/resources/k8s/values.yaml")
  ]

  set_sensitive = [
    {
      name  = "app.dbconfig.user"
      value = data.terraform_remote_state.infra.outputs.order_dbuser
    },
    {
      name  = "app.dbconfig.password"
      value = data.terraform_remote_state.infra.outputs.order_dbpassword
    }
  ]

  set = [
    {
      name  = "app.image.tag"
      value = "latest"
    },
    {
      name  = "app.dbconfig.host"
      value = data.terraform_remote_state.infra.outputs.dbhost
    },
    {
      name  = "app.dbconfig.port"
      value = data.terraform_remote_state.infra.outputs.dbport
      type  = "string" # needed to ensure port is treated as string
    },
    {
      name  = "app.dbconfig.schema"
      value = "public"
    },
    {
      name  = "app.dbconfig.name"
      value = data.terraform_remote_state.infra.outputs.order_dbname
    }
  ]
}

resource "helm_release" "driver" {
  name             = "driver"
  namespace        = "default"
  chart            = "../../../cloudsovereignty-driver/resources/k8s"
  create_namespace = true
  wait             = true

  values = [
    file("../../../cloudsovereignty-driver/resources/k8s/values.yaml")
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

/*
ToDo: Add ingress controller if needed
resource "helm_release" "caddy_ingress" {
  name             = "mycaddy"
  repository       = "https://caddyserver.github.io/ingress/"
  chart            = "caddy-ingress-controller"
  namespace        = "caddy-system"
  atomic           = true
  create_namespace = true
}
*/
