


variable "vnet_config" {
  type = map(object({
    vnet-name                = string
    location            = string
    resource_group_name = string
    address_space       = list(string)
  }))
}

variable "subnet_config" {
  type = map(object({
    subnet-name                 = string
    resource_group_name  = string
    virtual_network_name = string
    address_prefixes     = list(string)
  }))
}