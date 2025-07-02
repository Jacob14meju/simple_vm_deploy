provider "azurerm" {
  features {
  }
}

resource "azurerm_resource_group" "main_rg" {
  name = "main_rg"
  location = "East Us"
}

resource "azurerm_network_security_group" "main_sg" {
  name = "main_sg"
  resource_group_name = azurerm_resource_group.main_rg.name
  location = azurerm_resource_group.main_rg.location
}

resource "azurerm_virtual_network" "main_vnet" {
  name = "main_vnet"
  resource_group_name = azurerm_resource_group.main_rg.name
  location = azurerm_resource_group.main_rg.location
  address_space = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "main_sub" {
  name = "main_sub"
  resource_group_name = azurerm_resource_group.main_rg.name
  virtual_network_name = azurerm_virtual_network.main_vnet.name
  address_prefixes = ["10.0.2.0/24"]
}

resource "azurerm_public_ip" "main_pub_ip" {
  resource_group_name = azurerm_resource_group.main_rg.name
  location = azurerm_resource_group.main_rg.location
  name = "main_pub_ip"
  allocation_method = "Dynamic"
}

resource "azurerm_network_interface" "main_nic" {
  name = "main_nic"
  resource_group_name = azurerm_resource_group.main_rg.name
  location = azurerm_resource_group.main_rg.location
  ip_configuration {
    name = "internal"
    private_ip_address_allocation = "Dynamic"
    subnet_id = azurerm_subnet.main_sub.id
  }
}

module "vm1" {
  source = "modules/vm"
  vm_name = "vm1"
  vm_nic = azurerm_network_interface.id
  
}

resource "time_sleep" "wait_for_pub_ip" {
  create_duration = "30"
}





