

resource "azurerm_virtual_network" "vnet" {
  for_each = var.vnet_config

  name                = each.value.vnet-name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  address_space       = each.value.address_space
}


resource "azurerm_subnet" "subnet" {
  for_each = var.subnet_config

  name                 = each.value.subnet-name
  resource_group_name  = each.value.resource_group_name
  virtual_network_name = each.value.virtual_network_name
  address_prefixes      = each.value.address_prefixes
}
