terraform {
  backend "consul" {
    address = "127.0.0.1:8500"
    path = "aci/app-hearth/tfstate"
    scheme = "http"
    lock = "true"
  }
}
