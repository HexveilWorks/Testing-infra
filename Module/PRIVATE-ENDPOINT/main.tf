





resource "azurerm_private_endpoint" "kv_pe" {
  
  for_each            = var.kv_pe
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  subnet_id           = var.subnet_ids[each.value.subnet_id]

private_service_connection {
  name                           = "kv-private-connection"
  private_connection_resource_id = each.value.private_service_connection["keyvault"].private_connection_resource_id
  subresource_names              = ["vault"]
  is_manual_connection           = false
}

  private_dns_zone_group {

      name                 = each.value.private_dns_zone_group["keyvault"].name
    private_dns_zone_ids   = each.value.private_dns_zone_group["keyvault"].private_dns_zone_ids
    
  }
}


