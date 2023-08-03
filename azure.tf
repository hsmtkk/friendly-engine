provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "default" {
  location = var.east
  name     = var.project
}