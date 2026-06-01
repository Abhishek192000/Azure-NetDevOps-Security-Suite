# 1. Outbound Directional Lane: Central Hub pointing to Production Spoke
resource "azurerm_virtual_network_peering" "hub_to_prod" {
  name                      = "peer-hub-to-prod"
  resource_group_name       = azurerm_resource_group.rg.name
  virtual_network_name      = azurerm_virtual_network.hub_vnet.name
  remote_virtual_network_id = azurerm_virtual_network.prod_spoke.id
}

# 2. Return Directional Lane: Production Spoke pointing back to Central Hub
resource "azurerm_virtual_network_peering" "prod_to_hub" {
  name                      = "peer-prod-to-hub"
  resource_group_name       = azurerm_resource_group.rg.name
  virtual_network_name      = azurerm_virtual_network.prod_spoke.name
  remote_virtual_network_id = azurerm_virtual_network.hub_vnet.id
}

# 3. Create a Custom Route Table for the Spoke Network
resource "azurerm_route_table" "spoke_rt" {
  name                          = "rt-spoke-to-hub-fw"
  location                      = azurerm_resource_group.rg.location
  resource_group_name           = azurerm_resource_group.rg.name
  bgp_route_propagation_enabled = false # Blocks on-prem route hijacking

  # The Traffic Hijack Rule (UDR)
  route {
    name           = "route-all-traffic-through-hub-fw"
    address_prefix = "0.0.0.0/0" # Targets absolutely ALL outbound traffic
    next_hop_type  = "VirtualAppliance" # Tells Azure a firewall is handling the packet
    next_hop_in_ip_address = "10.0.1.4" # Pre-allocated private IP address of the future firewall core
  }
}

# 4. Bind the Route Table directly to your Production Spoke App Subnet
resource "azurerm_subnet_route_table_association" "assoc" {
  subnet_id = azurerm_subnet.prod_app_subnet.id
  route_table_id = azurerm_route_table.spoke_rt.id
}
