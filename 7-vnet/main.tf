# main.tf — Lab 1: VNet básica

resource "azurerm_resource_group" "rg" {
  name     = "rg-lab1"
  location = "East US"
}

resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-lab1"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet" "subnet" {
  name                 = "subnet-web"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/26"]
}