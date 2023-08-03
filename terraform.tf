terraform {
  backend "azurerm" {
    resource_group_name  = "friendly-engine-backend"
    storage_account_name = "friendlyenginebackend"
    container_name       = "tfstate"
    key                  = "tfstate"
  }
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
    }
  }
}
