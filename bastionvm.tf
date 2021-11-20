#Creating Public IP for Bastion VNIC
resource "azurerm_public_ip" "bastion-pip" {
  name                = "bastion-pip"
  resource_group_name = azurerm_resource_group.basicrg.name
  location            = azurerm_resource_group.basicrg.location
  allocation_method   = "Dynamic"
  tags                = var.tags
}

#Creating Network Interface for Bastion VM

resource "azurerm_network_interface" "bastion-nic" {
  name                = "bastion-nic"
  location            = azurerm_resource_group.basicrg.location
  resource_group_name = azurerm_resource_group.basicrg.name
  tags = var.tags

  ip_configuration {
    name                          = "bastion-pip"
    subnet_id                     = azurerm_subnet.bastion-subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.bastion-pip.id
  }
}


#Creating Windows Bastion VM

resource "azurerm_windows_virtual_machine" "bastion-vm" {
  name                  = "bastion-vm"
  resource_group_name   = azurerm_resource_group.basicrg.name
  location              = azurerm_resource_group.basicrg.location
  size                  = "Standard_b2ms"
  admin_username        = var.username
  admin_password        = "P@ssw0rd@123"
  network_interface_ids = [azurerm_network_interface.bastion-nic.id]
  tags = var.tags

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }
}