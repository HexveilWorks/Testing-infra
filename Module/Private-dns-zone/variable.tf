
variable "dnszone" {
  type = map(object({
    name                = string
    resource_group_name = string
  }))
}

variable "dnslink" {
  type = map(object({
    name                = string
    dns_zone_key        = string
    virtual_network_id  = string
  }))
}


variable "vnet_ids" {
  type = map(string)
}