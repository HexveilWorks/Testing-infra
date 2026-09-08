
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
     vnet_key     = string
  }))
}


variable "vnet_ids" {
  type = map(string)
}