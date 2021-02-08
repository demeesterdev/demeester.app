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