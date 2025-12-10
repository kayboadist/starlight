module "starlight-aks1" {
  source              = "./modules/aks"
  resource_group_name = azurerm_resource_group.starlight-rg.name
  location            = azurerm_resource_group.starlight-rg.location
  cluster_name        = "starlight-aks1"
  environment         = var.environment
  node_count          = var.node_count
  depends_on          = [azurerm_resource_group.starlight-rg]
}

# module "starlight-aks2" {
#   source              = "./modules/aks"
#   resource_group_name = azurerm_resource_group.starlight-rg.name
#   location           = azurerm_resource_group.starlight-rg.location
#   cluster_name       = "starlight-aks2"
#   environment        = var.environment
#   depends_on         = [azurerm_resource_group.starlight-rg]
# }