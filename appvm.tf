#Creating Network Interface for APP VM
resource "azurerm_network_interface" "app-nic" {
  name                = "app-nic"
  location            = azurerm_resource_group.basicrg.location
  resource_group_name = azurerm_resource_group.basicrg.name
  tags = var.tags

  ip_configuration {
    name                          = "app-ip"
    subnet_id                     = azurerm_subnet.app-subnet.id
    private_ip_address_allocation = "Static"
  }
}


#Creating App VM

resource "azurerm_virtual_machine" "app-vm" {
    name = "${var.prefix}-app-vm"
    location = azurerm_resource_group.basicrg.location
    resource_group_name = azurerm_resource_group.basicrg.name
    network_interface_ids = [azurerm_network_interface.app-nic.id]
    vm_size = var.vm_size
    tags = var.tags

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