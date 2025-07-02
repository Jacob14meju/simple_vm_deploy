resource "azurerm_linux_virtual_machine" "vm1" {
  name = var.vm_name
  location = var.vm_location
  resource_group_name = var.vm_rg
  network_interface_ids = var.vm_nic
  size = "Standard_F2"
  admin_username = var.vm_user
  admin_ssh_key {
    username   = var.vm_user
    public_key = var.vm_sssh_key
  }
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}