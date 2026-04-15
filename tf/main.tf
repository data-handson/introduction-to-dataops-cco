terraform {
  required_version = ">= 1.8"
 
  backend "azurerm" {
    resource_group_name  = "rg-hands-on-introduction-to-dataops"
    storage_account_name = "handsondataopsbackend"
    container_name       = "cco-backend"
    key                  = "backend_dev.tfstate"
  }
 
  required_providers {
    fabric = {
      source  = "microsoft/fabric"
      version = ">= 1.9.0"
    }
 
    azuread = {
      source  = "hashicorp/azuread"
      version = ">= 3.0.0"
    }
  }
}
 
provider "azurerm" {
  subscription_id = "0864cee4-2d12-4a41-b878-50f960ea5139"
  features {}
}
 
resource "fabric_workspace" "dev" {
  display_name = "[HANDS-ON] CCO2 Workspace - DEV"
  description  = "Fabric workspace for the Introduction to DataOps learning path."
  capacity_id  = "d38db894-91ed-4915-901d-3d229662e961"

  identity = {
    type = "SystemAssigned"
  }
}