
variable "vnet-peering" {

  description = "A map of virtual network peering configurations."
  type        = map(object({
    peering-name                         = string
    resource_group_name          = string
    virtual_network_name         = string
    remote_virtual_network_id    = string
    allow_virtual_network_access = bool
    allow_forwarded_traffic      = bool
    allow_gateway_transit        = bool
  }))
}
