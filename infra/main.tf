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
      name = "app-infra"
    }
  }
}

provider "azurerm" {
  features {}
}