

variable "cosmosdb_accounts" {
  description = "Cosmos DB MongoDB accounts"

  type = map(object({
    db-account-name                = string
    location            = string
    resource_group_name = string
    offer_type          = string
    kind                = string
    mongo_server_version = string

    consistency_level = string

    geo_location = object({
      location          = string
      failover_priority = number
    })
  }))
}

variable "mongo_databases" {
  description = "MongoDB databases to create in Cosmos DB"

  type = map(object({
    db-name         = string
    account_key  = string
  }))
}


variable "mongo_collections" {
  description = "MongoDB collections to create"

  type = map(object({
    collection-name         = string
    account_key  = string
    database_key = string
    shard_key    = string
  }))
}
