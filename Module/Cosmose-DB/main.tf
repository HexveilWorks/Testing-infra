
resource "azurerm_cosmosdb_account" "cosmos" {
  for_each = var.cosmosdb_accounts

  name                = each.value.db-account-name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  offer_type           = each.value.offer_type
  kind                 = each.value.kind

  mongo_server_version = each.value.mongo_server_version

  consistency_policy {
    consistency_level = each.value.consistency_level
  }

  geo_location {
    location          = each.value.geo_location.location
    failover_priority = each.value.geo_location.failover_priority
  }
}


resource "azurerm_cosmosdb_mongo_database" "database" {
  for_each = var.mongo_databases

  name                = each.value.db-name
  resource_group_name = var.cosmosdb_accounts[each.value.account_key].resource_group_name

  account_name = azurerm_cosmosdb_account.cosmos[each.value.account_key].account_name
}



resource "azurerm_cosmosdb_mongo_collection" "collection" {
  for_each = var.mongo_collections

  name                = each.value.collection-name
  resource_group_name = var.cosmosdb_accounts[each.value.account_key].resource_group_name

  account_name = azurerm_cosmosdb_account.cosmos[each.value.account_key].account_name

  database_name = azurerm_cosmosdb_mongo_database.database[each.value.database_key].database_name

  shard_key = each.value.shard_key
}


