

resource "azurerm_virtual_network_peering" "peering" {

    for_each = var.vnet-peering
  
  name                         = each.value.peering-name
  resource_group_name          = each.value.resource_group_name
  virtual_network_name         = each.value.virtual_network_name
  remote_virtual_network_id    = each.value.remote_virtual_network_id
  allow_virtual_network_access = each.value.allow_virtual_network_access
  allow_forwarded_traffic      = each.value.allow_forwarded_traffic

  # `allow_gateway_transit` must be set to false for vnet Global Peering
  allow_gateway_transit = false
}