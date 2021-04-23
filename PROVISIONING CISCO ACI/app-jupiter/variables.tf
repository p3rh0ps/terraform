variable "apic_url" {
  description = " APIC URL used as API Endpoint to configure Cisco ACI"
  type = string
  default = "https://10.10.198.3"
}
variable "apic_username" {
  description = "APIC User used to configure Cisco ACI"
}
variable "cert_file" {
  description = "Named of the Pub Certificate used for signature authentication with Cisco ACI"
}
variable "key_file" {
  description = "keyfile to sign requests"
}
variable "dmz_subnet_cidr_blocks" {
  description = "Available cidr blocks for dmz subnets."
  type        = list(string)
  default     = [
    "10.0.1.0/24",
    "10.0.2.0/24",
    "10.0.3.0/24",
    "10.0.4.0/24",
    "10.0.5.0/24",
    "10.0.6.0/24",
    "10.0.7.0/24",
    "10.0.8.0/24",
  ]
}

variable "private_subnet_cidr_blocks" {
  description = "Available cidr blocks for private subnets."
  type        = list(string)
  default     = [
    "10.0.101.0/24",
    "10.0.102.0/24",
    "10.0.103.0/24",
    "10.0.104.0/24",
    "10.0.105.0/24",
    "10.0.106.0/24",
    "10.0.107.0/24",
    "10.0.108.0/24",
  ]
}
