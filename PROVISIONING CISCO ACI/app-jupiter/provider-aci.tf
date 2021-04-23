#configure provider with your cisco aci credentials.
provider "aci" {
  username = var.apic_username
  #password    = "Wheel123"
  private_key = var.key_file
  cert_name   = var.cert_file
  url         = var.apic_url
  insecure    = true
}
