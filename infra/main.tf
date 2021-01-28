terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 2.26"
    }
  }
  backend "remote" {
    organization = "demeesterdev"
    workspaces {
      name = "demeesterapp"
    }
  }
}


provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "demdev-dns" {
  name     = "demdev-dns"
  location = "West Europe"
}

resource "azurerm_dns_zone" "demdev-dns-public" {
  name                = "demdev.app"
  resource_group_name = azurerm_resource_group.demdev-dns.name

  lifecycle {
    prevent_destroy = true
  }
}