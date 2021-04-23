# 
locals {
  jupiterSats = csvdecode(file("jupiterSatellite.csv"))
}

resource "aci_tenant" "ALLSTARS" {
  name        = "ALLSTARS"
  description = "This tenant is created by terraform"
}

resource "aci_application_profile" "appJupiter" {
  tenant_dn   = aci_tenant.ALLSTARS.id
  name        = "appJupiter"
  description = "This app profile is created by terraform"
}

resource "aci_application_epg" "sat" {

  for_each               = { for sat in local.jupiterSats : sat.localId => sat }
  application_profile_dn = aci_application_profile.appJupiter.id
  name                   = "epg${each.value.name}"
  description            = "This a satellite from ${each.value.parent}"
  annotation             = ""
  exception_tag          = "0"
  flood_on_encap         = "disabled"
  fwd_ctrl               = "none"
  has_mcast_source       = "no"
  is_attr_based_epg      = "no"
  match_t                = "AtleastOne"
  name_alias             = each.value.numeral
  pc_enf_pref            = "unenforced"
  pref_gr_memb           = "exclude"
  prio                   = "unspecified"
  shutdown               = "no"
}

output "epg_listing" {
  value = { for sat in local.jupiterSats : sat.localId => sat }
}
