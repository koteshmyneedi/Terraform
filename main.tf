<<<<<<< HEAD
# We strongly recommend using the required_providers block to set the
# Azure Provider source and version being used
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
     features {}
  subscription_id   ="1523994f-97da-4266-bdaf-e672e90450eb"
   client_id          = "6145deef-8b85-4a7b-bba1-5e4634cfc666"
    tenant_id        = "89986706-08a7-478a-abc7-bb5372e77f99"
    client_secret    = "I8Z8Q~jv3~dvmgBsXnQxhJzlkAsjxwRprQpPsdgH"
    
}

# Create a resource group
resource "azurerm_resource_group" "rg1" {
  name     = "${var.rgname}"
  location = "${var.rglocation}"
}

# Create a virtual network within the resource group
resource "azurerm_virtual_network" "vnet1" {
  name                = "${var.vnetname}"
  resource_group_name = azurerm_resource_group.rg1.name
  location            = azurerm_resource_group.rg1.location
  address_space       = ["${var.vnet_cidr}"]
}

# Create a subnet within the virtual network
resource "azurerm_subnet" "subnet1" {
  name                 = "${var.subnetname}"
  resource_group_name  = azurerm_resource_group.rg1.name
  virtual_network_name = azurerm_virtual_network.vnet1.name
  address_prefixes     = ["${var.subnet_cidr}"]
}

# create a network security group
resource "azurerm_network_security_group" "nsg" {
  name                = "${var.nsgname}"
  location            = azurerm_resource_group.rg1.location
  resource_group_name = azurerm_resource_group.rg1.name

  security_rule {
    name                       = "RDP"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"

  }
}

resource "azurerm_subnet_network_security_group_association" "nsg_subnet_assoc" {
  subnet_id                 = azurerm_subnet.subnet1.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

resource "azurerm_network_interface" "nic1" {
  name                = "${var.nicname}"
  location            = azurerm_resource_group.rg1.location
  resource_group_name = azurerm_resource_group.rg1.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet1.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_windows_virtual_machine" "vm1" {
  name                  = "${var.vmname}"
  resource_group_name   = azurerm_resource_group.rg1.name
  location              = azurerm_resource_group.rg1.location
  size                  = "Standard_D2a_v4"
  admin_username        = "Azureadmin"
  admin_password        = "Admin@1234"
  network_interface_ids = [azurerm_network_interface.nic1.id]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2025-Datacenter"
    version   = "latest"
  }
}
=======
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=5.0.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}

  subscription_id   ="1523994f-97da-4266-bdaf-e672e90450eb"
   client_id          = "6145deef-8b85-4a7b-bba1-5e4634cfc666"
    tenant_id        = "89986706-08a7-478a-abc7-bb5372e77f99"
    client_secret    = "I8Z8Q~jv3~dvmgBsXnQxhJzlkAsjxwRprQpPsdgH"
    
}

# Create a resource group
resource "azurerm_resource_group" "rg1" {
  name     = "${var.rgname}"
  location = "${var.rglocation}"
}

# Create a virtual network within the resource group
resource "azurerm_virtual_network" "vnet1" {
  name                = "${var.vnetname}"
  resource_group_name = azurerm_resource_group.rg1.name
  location            = azurerm_resource_group.rg1.location
  address_space       = ["${var.vnet_cidr}"]
}


resource "azurerm_subnet" "Subnet1" {
  name                 = "${var.subnetname}"
  resource_group_name  = azurerm_resource_group.rg1.name
  virtual_network_name = azurerm_virtual_network.vnet1.name
  address_prefixes     = ["${var.subnet_cidr}"]
}
>>>>>>> eef3f2662cf52a3056916d2330111b5c3fbac4b7
