# outputs.tf
output "vnet_hub_id" {
  value = azurerm_virtual_network.hub.id
}

output "vnet_spoke_ids" {
  value = { for k, s in azurerm_virtual_network.spoke : k => s.id }
}
