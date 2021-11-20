terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.84.0"
    }
  }
}

provider "azurerm" {
  # Configuration options
  features {}
}

#Creating a new Resource Group
resource "azurerm_resource_group" "basicrg" {
  name     = "${var.environment}-basicrg"
  location = "East US"
  tags     = var.tags
}
