#Creating Network Security Groups

resource "azurerm_network_security_group" "bastion-nsg" {
  name                = "${var.environment}-${var.bstnnsg}"
  resource_group_name = azurerm_resource_group.basicrg.name
  location            = azurerm_resource_group.basicrg.location
  tags                = var.tags
}

resource "azurerm_network_security_rule" "bastion-rdp" {
    name                       = "RDP_Access"
    priority                   = 1000
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = var.local_pip
    destination_address_prefix = "*"
    resource_group_name        = azurerm_resource_group.basicrg.name
    network_security_group_name = azurerm_network_security_group.bastion-nsg.name
}

resource "azurerm_network_security_group" "web-nsg" {
  name                = "${var.environment}-${var.webnsg}"
  resource_group_name = azurerm_resource_group.basicrg.name
  location            = azurerm_resource_group.basicrg.location
  tags                = var.tags
}

resource "azurerm_network_security_rule" "web-ssh" {
    name                       = "SSH_Port_Open"
    priority                   = 1000
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = var.local_pip
    destination_address_prefix = "*"
    resource_group_name        = azurerm_resource_group.basicrg.name
    network_security_group_name = azurerm_network_security_group.web-nsg.name
}

#Created new NSG for app
resource "azurerm_network_security_group" "app-nsg" {
  name                = "${var.environment}-${var.appnsg}"
  resource_group_name = azurerm_resource_group.basicrg.name
  location            = azurerm_resource_group.basicrg.location
  tags                = var.tags
}

resource "azurerm_network_security_rule" "app-ssh" {
    name                       = "SSH_Port_Open"
    priority                   = 1000
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "${var.local_pip}"
    destination_address_prefix = "*"
    resource_group_name        = azurerm_resource_group.basicrg.name
    network_security_group_name = azurerm_network_security_group.app-nsg.name
}


#Creating Subnet and Network Security Group association block
#resource "azurerm_subnet_network_security_group_association" "bastion-association" {
#  subnet_id                 = azurerm_subnet.bastion-subnet.id
#  network_security_group_id = azurerm_network_security_group.bastion-nsg.id
#}

#resource "azurerm_subnet_network_security_group_association" "web-nsg-association" {
#  subnet_id                 = azurerm_subnet.web-subnet.id
#  network_security_group_id = azurerm_network_security_group.web-nsg.id
#}

#resource "azurerm_subnet_network_security_group_association" "app-nsg-association" {
#  subnet_id                 = azurerm_subnet.app-subnet.id
#  network_security_group_id = azurerm_network_security_group.app-nsg.id
#}
