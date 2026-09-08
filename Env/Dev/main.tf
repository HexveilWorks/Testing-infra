

module "rg" {
  source  = "../../Module/Resource-group"
  rg_name = var.rg_name
}

module "vnet" {
  source = "../../Module/vnet"

  vnet_config   = var.vnet_config
  subnet_config = var.subnet_config
}

module "aks" {
  source  = "../../Module/AKS"
  aks_cluster = var.aks_cluster
  subnet_ids = module.vnet.subnet_ids
  depends_on = [module.vnet]
}

module "dnslink" {
  source     = "../../Module/Private-dns-zone"
dnszone=var.dnszone
dnslink=var.dnslink
depends_on = [module.rg, module.vnet]
vnet_ids = module.vnet.vnet_ids
}


module "privateendpoint" {
  source     = "../../Module/PRIVATE-ENDPOINT"
  kv_pe      = var.kv_pe
  depends_on = [module.rg, module.vnet, module.dnslink]
  subnet_ids = module.vnet.subnet_ids
}

