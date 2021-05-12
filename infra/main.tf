terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 2.26"
    }
    acme = {
      source  = "vancluever/acme"
      version = "2.0.0"
    }
  }
}

provider "azurerm" {
  features {}
}
