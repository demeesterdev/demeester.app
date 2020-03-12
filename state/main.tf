provider "azurerm" {
    version = "~> 2.1"
    features {}
}

resource "azurerm_resource_group" "tfstate" {
  name     = "demdev-tfstate"
  location = "West Europe"
}

resource "azurerm_storage_account" "tfstate" {
  name                     = "demdevtfstate"
  resource_group_name      = azurerm_resource_group.tfstate.name
  location                 = azurerm_resource_group.tfstate.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    tf_managed = "true"
  }
}