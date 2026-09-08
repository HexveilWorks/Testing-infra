resource "azurerm_private_dns_zone" "dns_zone" {
  for_each = var.dnszone

  name                = each.value.name
  resource_group_name = each.value.resource_group_name

  
}


resource "azurerm_private_dns_zone_virtual_network_link" "dnslink" {
  for_each = var.dnslink
  name                = each.value.name
  
  private_dns_zone_id = azurerm_private_dns_zone.dns_zone[each.value.dns_zone_key ].id
  virtual_network_id  = var.vnet_ids[each.value.vnet_key]

}





