terraform {
  required_version = ">= 1.8"
 
  backend "azurerm" {
    resource_group_name  = "rg-hands-on-introduction-to-dataops"
    storage_account_name = "handsondataopsbackend"
    container_name       = "sam-backend"
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
 
variable "target_environment" {
  description = "The environment to deploy (dev or prd)"
  type        = string
 
  validation {
    condition     = contains(["dev", "prd"], var.target_environment)
    error_message = "target_environment must be 'dev' or 'prd'."
  }
}
 
