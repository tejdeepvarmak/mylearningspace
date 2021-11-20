#Creating Public IP for Web VNIC
resource "azurerm_public_ip" "web-pip" {
  name                = "web-pip"
  resource_group_name = azurerm_resource_group.basicrg.name
  location            = azurerm_resource_group.basicrg.location
  allocation_method   = "Dynamic"
  tags                = var.tags
}


#Creating a Network Interface for Web VM
resource "azurerm_network_interface" "web-nic" {
  name                = "web-nic"
  location            = azurerm_resource_group.basicrg.location
  resource_group_name = azurerm_resource_group.basicrg.name
  tags = var.tags

  ip_configuration {
    name                          = "web-pip"
    subnet_id                     = azurerm_subnet.web-subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.web-pip.id
  }
}



#Creating Web VM

resource "azurerm_virtual_machine" "web-vm" {
  name                  = "$(var.prefix)-web-vm"
  location              = azurerm_resource_group.basicrg.location
  resource_group_name   = azurerm_resource_group.basicrg.name
  network_interface_ids = [azurerm_network_interface.web-nic.id]
  vm_size               = var.vm_size
  tags = var.tags

  # Uncomment this line to delete the OS disk automatically when deleting the VM
  # delete_os_disk_on_termination = true

  # Uncomment this line to delete the data disks automatically when deleting the VM
  # delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
  storage_os_disk {
    name              = "web-osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "web-vm"
    admin_username = var.username
    admin_password = "P@ssw0rd@123"
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
}