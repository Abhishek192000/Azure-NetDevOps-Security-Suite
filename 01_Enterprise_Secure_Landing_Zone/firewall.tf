# 1. Allocate a Static Public IP for the Firewall
resource "azurerm_public_ip" "fw_pip" {
  name                = "pip-hub-firewall"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
  sku                 = "Standard" # Required SKU for Azure Firewall perimeters
}

# 2. Deploy the Central Firewall Engine Core
resource "azurerm_firewall" "hub_fw" {
  name                = "fw-hub-central"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku_name            = "AZFW_VNet" # Standard deployment mode
  sku_tier            = "Premium"   # Activates advanced IDPS & TLS inspection features

  # Bind the Firewall to your predefined network properties
  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.fw_subnet.id # Pulls your exact "AzureFirewallSubnet"
    public_ip_address_id = azurerm_public_ip.fw_pip.id
  }
}
