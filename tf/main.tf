# Step 1: Setup the lab environment
terraform {
  required_version = ">= 1.8"

  backend "azurerm" {
    resource_group_name  = "rg-hands-on-introduction-to-dataops"
    storage_account_name = "handsondataopsbackend"
    container_name       = "cco-backend"
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


# Step 2: Create Fabric workspace, lakehouse and role assignment (direct resources)
resource "fabric_workspace" "dev" {
  display_name = "[HANDS-ON] CCO Workspace - DEV"
  description  = "Fabric workspace for the Introduction to DataOps learning path."
  capacity_id  = "d38db894-91ed-4915-901d-3d229662e961"

  identity = {
    type = "SystemAssigned"
  }
}

resource "fabric_lakehouse" "dev" {
  display_name = "lkh_dev_hands_on"
  workspace_id = fabric_workspace.dev.id
  description  = "Fabric lakehouse for the Introduction to DataOps learning path."

  configuration = {
    enable_schemas = true
  }
}

resource "fabric_workspace_role_assignment" "dev" {
  workspace_id = fabric_workspace.dev.id

  principal = {
    id   = "cd76f376-e762-47e8-b795-a05d40e61f67"
    type = "Group"
  }

  role = "Contributor"
}
