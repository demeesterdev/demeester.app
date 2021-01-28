terraform {
  backend "remote" {
    organization = "demeesterdev"

    workspaces {
      name = "terraform-cloud"
    }
  }

  required_providers {
    tfe = {
      source  = "hashicorp/tfe"
      version = "~> 0.24.0"
    }
    azuread =  {
      source  = "hashicorp/azuread"
      version = "~>0.7.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 2.26"
    }
  }
}

provider "azurerm" {
  features {}
}

provider "azuread" {
  tenant_id = var.tenant_id
}