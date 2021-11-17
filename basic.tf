terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "2.84.0"
    }
  }
}

provider "azurerm" {
  # Configuration options
  features{}
} 

resource "azurerm_resource_group" "basicrg" {
    name = "basicrg"
    location = "East US"
}
