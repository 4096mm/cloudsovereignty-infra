terraform {
  required_providers {
    stackit = {
      source = "stackitcloud/stackit"
      version = "0.76.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "2.6.1"
    }
  }
}