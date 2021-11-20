#Creating Virtual Network
resource "azurerm_virtual_network" "basicvnet" {
  name                = "${var.prefix}-basicvnet"
  location            = azurerm_resource_group.basicrg.location
  resource_group_name = azurerm_resource_group.basicrg.name
  address_space       = ["10.20.0.0/16"]
  tags = var.tags
}


#Creating Subnets
resource "azurerm_subnet" "bastion-subnet" {
  name                 = "bastion-subnet"
  resource_group_name  = azurerm_resource_group.basicrg.name
  virtual_network_name = azurerm_virtual_network.basicvnet.name
  address_prefixes     = ["10.20.1.0/24"]
}

resource "azurerm_subnet" "web-subnet" {
  name                 = "web-subnet"
  resource_group_name  = azurerm_resource_group.basicrg.name
  virtual_network_name = azurerm_virtual_network.basicvnet.name
  address_prefixes     = ["10.20.2.0/24"]
}

#created new subnet
resource "azurerm_subnet" "app-subnet" {
  name                 = "app-subnet"
  resource_group_name  = azurerm_resource_group.basicrg.name
  virtual_network_name = azurerm_virtual_network.basicvnet.name
  address_prefixes     = ["10.20.3.0/24"]
}