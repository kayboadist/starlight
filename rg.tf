resource "azurerm_resource_group" "starlight-rg" {
  name     = var.resource_group_name
  location = var.location
}
