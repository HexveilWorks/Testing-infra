


variable "subscription_id" {
  default     = "fbb258e2-cd4d-4bd2-9c7d-a04b5cf93aaa"
}


variable "rg_name" {
    type = map(object({
        name = string
        location = string
    }))
} 

variable "vnet_config" {
  type = map(object({
    vnet-name           = string
    location            = string
    resource_group_name = string
    address_space       = list(string)
  }))
}

variable "subnet_config" {
  type = map(object({
    subnet-name          = string
    resource_group_name  = string
    virtual_network_name = string
    address_prefixes     = list(string)
  }))
}


variable "aks_cluster" {
  type = map(object({

    name                = string
    location            = string
    resource_group_name = string
    kubernetes_version  = string
    dns_prefix          = string
    private_cluster_enabled = bool


    default_node_pool = map(object({
      name                  = string
      auto_scaling_enabled  = bool
      min_count             = number
      max_count             = number
      vm_size               = string
    }))

    network_profile = map(object({
      network_plugin    = string
      network_policy    = string
      load_balancer_sku = string
    }))
  }))
}



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



variable "kv_pe" {
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
    subnet_name         = string
    key_vault_name      = string

    private_service_connection = map(object({
      name                           = string
      private_connection_resource_id = string
      subresource_names              = list(string)
      is_manual_connection           = bool
    }))

    private_dns_zone_group = map(object({
      name                 = string
      private_dns_zone_ids = list(string)
    }))
  }))
}





