terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

provider "azurerm" {
  subscription_id = local.subscription_id
  client_id       = local.client_id
  client_secret   = local.client_secret
  tenant_id       = local.tenant_id
  features {}
}

resource "azurerm_resource_group" "app_rg" {
  name     = local.resource_group
  location = local.location
}

resource "azurerm_kubernetes_cluster" "kubernetes_cluster" {
  name                = local.cluster_name
  location            = local.location
  resource_group_name = local.resource_group
  dns_prefix          = "wmizera"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_DS2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin = "azure"
    network_policy = "azure"
  }

  depends_on = [ azurerm_resource_group.app_rg ]
}