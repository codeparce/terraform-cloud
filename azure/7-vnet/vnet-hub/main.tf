# VNet Hub (compartida)
resource "azurerm_resource_group" "rg" {
  name     = var.rg_name
  location = var.location
}

resource "azurerm_virtual_network" "hub" {
  name                = "vnet-hub"
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
}

# VNet Spoke [dev y prod]
resource "azurerm_virtual_network" "spoke" {
  for_each            = var.vnet_spoke
  name                = "vnet-spoke-${each.key}"
  address_space       = [each.value]
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
}

# Peering: Hub → Spoke
resource "azurerm_virtual_network_peering" "hub_to_spoke" {
  for_each                  = var.vnet_spoke
  name                      = "hub-to-spoke-${each.key}"
  resource_group_name       = azurerm_resource_group.rg.name
  virtual_network_name      = azurerm_virtual_network.hub.name
  remote_virtual_network_id = azurerm_virtual_network.spoke[each.key].id
  allow_forwarded_traffic   = true
  allow_gateway_transit     = true
}

# Peering: Spoke → Hub (bidireccional obligatorio)
resource "azurerm_virtual_network_peering" "spoke_to_hub" {
  for_each                  = var.vnet_spoke
  name                      = "spoke-to-hub-${each.key}"
  resource_group_name       = azurerm_resource_group.rg.name
  virtual_network_name      = azurerm_virtual_network.spoke[each.key].name
  remote_virtual_network_id = azurerm_virtual_network.hub.id
  allow_forwarded_traffic   = true
  use_remote_gateways       = false
}
