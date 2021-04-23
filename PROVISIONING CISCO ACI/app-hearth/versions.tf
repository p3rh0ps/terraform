terraform {
  required_providers {
    aci = {
      source  = "CiscoDevNet/aci"
      version = "0.5.4"
    }
  }
  required_version = ">= 0.13"
}
