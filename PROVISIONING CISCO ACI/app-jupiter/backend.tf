terraform {
  backend "consul" {
    address = "127.0.0.1:8500"
    path    = "aci/app-jupiter"
    scheme  = "http"
    lock    = "true"
  }
}
