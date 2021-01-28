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

resource "azurerm_dns_zone" "demeesterapp-dns-public" {
  name                = "demeester.app"
  resource_group_name = azurerm_resource_group.demdev-dns.name

  lifecycle {
    prevent_destroy = true
  }
}

resource "azurerm_dns_a_record" "example" {
  name                = "local"
  zone_name           = azurerm_dns_zone.demeesterapp-dns-public.name
  resource_group_name = azurerm_resource_group.demdev-dns.name
  ttl                 = 300
  records             = ["127.0.0.1"]
}



