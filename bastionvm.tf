#Creating Public IP for Bastion Public IP
resource "azurerm_public_ip" "bastion-pip" {
  name                = "${var.environment}-${var.bstn_pip}"
  resource_group_name = azurerm_resource_group.basicrg.name
  location            = azurerm_resource_group.basicrg.location
  allocation_method   = "Dynamic"
  tags                = var.tags
}

#Creating Network Interface for Bastion VM

resource "azurerm_network_interface" "bastion-nic" {
  name                = "${var.environment}-${var.bstn_nic}"
  location            = azurerm_resource_group.basicrg.location
  resource_group_name = azurerm_resource_group.basicrg.name
  tags                = var.tags

  ip_configuration {
    name                          = "${var.environment}-${var.bstn_pip}"
    subnet_id                     = azurerm_subnet.bastion-subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.bastion-pip.id
  }
}


#Creating Windows Bastion VM

resource "azurerm_windows_virtual_machine" "bastion-vm" {
  name                  = "${var.environment}-${var.bastionvm_name}"
  resource_group_name   = azurerm_resource_group.basicrg.name
  location              = azurerm_resource_group.basicrg.location
  size                  = var.vm_size
  admin_username        = var.username
  admin_password        = var.password
  network_interface_ids = [azurerm_network_interface.bastion-nic.id]
  tags                  = var.tags

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