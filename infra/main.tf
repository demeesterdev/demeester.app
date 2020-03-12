provider "azurerm" {
  version = "~> 2.1"
  features {}
}

resource "azurerm_resource_group" "k8s" {
  name     = "demdev-app-k8s"
  location = "West Europe"
}