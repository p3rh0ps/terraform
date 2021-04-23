# Definition of the provider

locals {
  serversToDeploy = csvdecode(file("customerSpecs.csv"))
}

provider "vsphere" {
  vsphere_server       = var.vsphere_server
  user                 = var.vsphere_user
  password             = var.vsphere_password
  allow_unverified_ssl = true
}

# Discovery of the vCenter caracteristics

data "vsphere_datacenter" "dc" {
  name = "DemoDC"
}

data "vsphere_datastore" "datastore" {
  name          = "datastore_1"
  datacenter_id = data.vsphere_datacenter.dc.id
}
data "vsphere_compute_cluster" "cluster" {
  name          = "Cluster_1"
  datacenter_id = data.vsphere_datacenter.dc.id
}
data "vsphere_resource_pool" "pool" {
  name          = "StackStorm"
  datacenter_id = data.vsphere_datacenter.dc.id
}
data "vsphere_network" "network" {
  name          = "VM Network"
  datacenter_id = data.vsphere_datacenter.dc.id
}
data "vsphere_virtual_machine" "template" {
  name          = "Template-18-04-LTS"
  datacenter_id = data.vsphere_datacenter.dc.id
}
data "vsphere_folder" "folder" {
  path = "/Demo-Center/vm/FLDStackStorm"
}

# Instantiation of the new VMs from the existing template Ubuntu 18.04.LTS

resource "vsphere_virtual_machine" "vm" {
  for_each         = { for vm in local.serversToDeploy : vm.uuid => vm }
  name             = each.value.srvName
  folder           = data.vsphere_folder.folder.path
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore.id
  firmware         = data.vsphere_virtual_machine.template.firmware
  num_cpus         = 2
  memory           = 4096
  guest_id         = data.vsphere_virtual_machine.template.guest_id
  scsi_type        = data.vsphere_virtual_machine.template.scsi_type
  # wait_for_guest_net_timeout  = 120
  # wait_for_guest_net_routable = false

  network_interface {
    network_id   = data.vsphere_network.network.id
    adapter_type = data.vsphere_virtual_machine.template.network_interface_types[0]
  }

  disk {
    label            = "disk0"
    size             = data.vsphere_virtual_machine.template.disks.0.size
    eagerly_scrub    = data.vsphere_virtual_machine.template.disks.0.eagerly_scrub
    thin_provisioned = data.vsphere_virtual_machine.template.disks.0.thin_provisioned
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.template.id

    customize {
      linux_options {
        host_name = each.value.srvName
        domain    = var.domainName
      }

      network_interface {
        ipv4_address = each.value.ipv4Addr
        ipv4_netmask = each.value.ipv4Mask
      }

      dns_server_list = var.dnsSrvList
      ipv4_gateway    = each.value.ipv4Gw
    }
  }
}

output "vm-listing" {
  value = { for vm in local.serversToDeploy : vm.uuid => vm }
}
