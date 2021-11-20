#Creating Virtual Network
resource "azurerm_virtual_network" "vnet" {
  name                = "${var.environment}-${var.vnet}"
  location            = azurerm_resource_group.basicrg.location
  resource_group_name = azurerm_resource_group.basicrg.name
  address_space       = var.vnet_add
  tags                = var.tags
}


#Creating Subnets
resource "azurerm_subnet" "bastion-subnet" {
  name                 = "${var.environment}-${var.bstn-sub}"
  resource_group_name  = azurerm_resource_group.basicrg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.bstn_add
}

resource "azurerm_subnet" "web-subnet" {
  name                 = "${var.environment}-${var.web-sub}"
  resource_group_name  = azurerm_resource_group.basicrg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.web_add
}

#created app subnet
resource "azurerm_subnet" "app-subnet" {
  name                 = "${var.environment}-${var.app-sub}"
  resource_group_name  = azurerm_resource_group.basicrg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.app_add
}