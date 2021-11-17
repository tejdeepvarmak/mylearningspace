#Creating Virtual Network
resource "azurerm_virtual_network" "basicvnet" {
    name = "basicvnet"
    location = azurerm_resource_group.basicrg.location
    resource_group_name = azurerm_resource_group.basicrg.name
    address_space = ["10.20.0.0/16"]
}


#Creating Subnets
resource "azurerm_subnet" "bastion-subnet" {
    name = "bastion-subnet"
    resource_group_name = azurerm_resource_group.basicrg.name
    virtual_network_name = azurerm_virtual_network.basicvnet.name
    address_prefixes = ["10.20.1.0/24"]
}

resource "azurerm_subnet" "web-subnet" {
    name = "web-subnet"
    resource_group_name = azurerm_resource_group.basicrg.name
    virtual_network_name = azurerm_virtual_network.basicvnet.name
    address_prefixes = ["10.20.2.0/24"]
}

#Creating Network Security Groups

resource "azurerm_network_security_group" "bastion-nsg" {
    name = "bastion-nsg"
    resource_group_name = azurerm_resource_group.basicrg.name
    location = azurerm_resource_group.basicrg.location
    
    security_rule {
    name                       = "RDP_Access"
    priority                   = 1000
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "223.178.24.142"
    destination_address_prefix = "*"
}
}

resource "azurerm_network_security_group" "web-nsg" {
    name = "web-nsg"
    resource_group_name = azurerm_resource_group.basicrg.name
    location = azurerm_resource_group.basicrg.location
    
    security_rule {
    name                       = "SSH_Port_Open"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "223.178.24.142"
    destination_address_prefix = "*"
}
}


# Creating Subnet and Network Security Group association block
resource "azurerm_subnet_network_security_group_association" "bastion-asso" {
    subnet_id = azurerm_subnet.bastion-subnet.id
    network_security_group_id = azurerm_network_security_group.bastion-nsg.id
}

resource "azurerm_subnet_network_security_group_association" "web-asso" {
    subnet_id = azurerm_subnet.web-subnet.id
    network_security_group_id = azurerm_network_security_group.web-nsg.id
}