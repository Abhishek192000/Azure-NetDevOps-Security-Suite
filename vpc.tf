# 1. Central Resource Group (The structural folder)
resource "azurerm_resource_group" "rg" {
  name     = "rg-netdevops-fortress"
  location = "Southeast Asia"
}

# 2. Central Hub Virtual Network (The Security Checkpoint Zone)
resource "azurerm_virtual_network" "hub_vnet" {
  name                = "vnet-hub-core"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["10.0.0.0/16"]
}

# Subnet inside Hub specifically reserved for your central Firewall engine
resource "azurerm_subnet" "fw_subnet" {
  name                 = "AzureFirewallSubnet" # This name must be exact for Azure to accept it
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.hub_vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}
# 3. Production Spoke Virtual Network (Isolated Application Zone)
resource "azurerm_virtual_network" "prod_spoke" {
  name                = "vnet-spoke-prod"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["10.1.0.0/16"] 
}

# Application Subnet inside the Production Spoke
resource "azurerm_subnet" "prod_app_subnet" {
  name                 = "snet-prod-apps"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.prod_spoke.name
  address_prefixes     = ["10.1.1.0/24"]
}
