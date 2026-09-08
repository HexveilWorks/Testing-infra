


rg_name = {
  rg1 = {
    name     = "rg-aks-prod"
    location = "West US"
  }
}


vnet_config = {
  vnet1 = {
    vnet-name           = "Hub-vnet-aks-dev"
    location            = "West US"
    resource_group_name = "rg-network-dev"
    address_space       = ["10.0.0.0/16"]
  }
   vnet2 = {
    vnet-name           = "Spoke-vnet-aks-dev"
    location            = "West US"
    resource_group_name = "rg-network-dev"
    address_space       = ["10.1.0.0/16"]
  }
}

subnet_config = {
  aks = {
    subnet-name          = "spoke-aks"
    resource_group_name  = "rg-network-dev"
    virtual_network_name = "vnet-aks-dev"
    address_prefixes     = ["10.0.1.0/24"]
  }
  private_endpoint = {
    subnet-name          = "snet-private-endpoint"
    resource_group_name  = "rg-network-dev"
    virtual_network_name = "vnet-aks-dev"
    address_prefixes     = ["10.0.2.0/24"]
  }
}

aks_cluster = {

  "aks_cluster" = {
    name                = "aks-cluster-private"
    location            = "Central india"
    resource_group_name = "riri-rg"
    kubernetes_version = "1.35.5"
    dns_prefix         = "aks"
    subnet_id  ="aks"
    private_cluster_enabled = true

    default_node_pool = {
      "nodepool1" = {
        name                  = "k8vms"
        auto_scaling_enabled  = true
        min_count             = 1
        max_count             = 4
        vm_size               = "standard_b2s_v2"
      }
    }
    network_profile = {

      "networkprofile1" = {

        network_plugin    = "azure"
        network_policy    = "calico"
        load_balancer_sku = "standard"
      }
    }
  }
}


dnszone = {
  aks = {
    name                =  "privatelink.centralindia.azmk8s.io"
    resource_group_name = "rg-network-dev"
  }

  cosmos-mongo = {
    name                = "privatelink.mongo.cosmos.azure.com"
    resource_group_name = "rg-network-dev"
  }
}


dnslink = {
  keyvault-link = {
    name               = "privatelink.centralindia.azmk8s.io"
    dns_zone_key       = "aks"
    vnet_key           = "vnet1"
  }

  cosmos-mongo-link = {
    name               = "privatelink.mongo.cosmos.azure.com"
    dns_zone_key       = "cosmos-mongo"
    vnet_key        = "vnet1"
  }
}



kv_pe = {
  keyvault = {
    name                = "pe-keyvault-dev"
    location            = "West US"
    resource_group_name = "rg-network-dev"
    subnet_id           = "aks"
    key_vault_name      = "kv-aks-dev"

    private_service_connection = {
      keyvault = {
        name                           = "psc-keyvault"
        private_connection_resource_id = "/subscriptions/<subscription-id>/resourceGroups/rg-network-dev/providers/Microsoft.KeyVault/vaults/kv-aks-dev"
        subresource_names              = ["MongoDB"]
        is_manual_connection            = false
      }
    }
    private_dns_zone_group = {
      keyvault = {
        name = "pdzg-keyvault"

        private_dns_zone_ids = [
          "/subscriptions/<subscription-id>/resourceGroups/rg-network-dev/providers/Microsoft.Network/privateDnsZones/privatelink.vaultcore.azure.net"
        ]
      }
    }
  }
}


vnet-peering = {
  aks-to-hub = {
    peering-name                  = "aks-to-hub"
    resource_group_name           = "rg-network-prod"
    virtual_network_name          = "vnet-aks-prod"
    remote_virtual_network_id     = "/subscriptions/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx/resourceGroups/rg-network-hub/providers/Microsoft.Network/virtualNetworks/vnet-hub"
    allow_virtual_network_access  = true
    allow_forwarded_traffic       = true
    allow_gateway_transit         = false
  }
}