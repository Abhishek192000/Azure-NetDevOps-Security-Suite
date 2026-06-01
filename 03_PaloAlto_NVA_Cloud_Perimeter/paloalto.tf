# 1. Allocate a Dedicated Management Network Interface for Palo Alto Ingress
resource "azurerm_network_interface" "pa_mgmt_nic" {
  name                = "nic-hub-paloalto-mgmt"
  location            = "East US" # Mirrors your exact Project 1 region topology
  resource_group_name = "rg-netdevops-fortress"

  ip_configuration {
    name                          = "mgmt-config"
    subnet_id                     = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-netdevops-fortress/providers/Microsoft.Network/virtualNetworks/vnet-hub-central/subnets/AzureFirewallSubnet"
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.0.1.10" # Fixes management endpoint mapping cleanly
  }
}

# 2. Provision the Enterprise Palo Alto VM-Series NGFW Core Appliance
resource "azurerm_virtual_machine" "pa_ngfw" {
  name                  = "nva-hub-paloalto-core"
  location              = "East US"
  resource_group_name   = "rg-netdevops-fortress"
  network_interface_ids = [azurerm_network_interface.pa_mgmt_nic.id]
  vm_size               = "Standard_D3_v2" # Standard minimum memory footprint required for PAN-OS data processing

  # Marketplace Reference parameters required for Third-Party NVAs
  storage_image_reference {
    publisher = "paloaltonetworks"
    offer     = "vmseries-flex"
    sku       = "byol"
    version   = "latest"
  }

  plan {
    name      = "vmseries-flex"
    publisher = "paloaltonetworks"
    product   = "vmseries-flex"
  }

  storage_os_disk {
    name              = "osdisk-hub-paloalto"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "pa-ngfw-hub"
    admin_username = "netdevopsadmin"
    admin_password = "SecureFortressPassword123!" # Enforces complex alpha-numeric parameters
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }
}
