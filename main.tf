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