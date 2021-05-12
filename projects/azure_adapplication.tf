data "azurerm_subscription" "primary" {
  subscription_id = var.subscription_id
}

resource "azuread_application" "tf_cloud" {
  name                       = "app.terraform.io (${var.tfe_organization.name})"
  homepage                   = "https://app.terraform.io/app/${var.tfe_organization.name}"
  available_to_other_tenants = false
  type                       = "webapp/api"
}

resource "azuread_service_principal" "tf_cloud" {
  application_id               = azuread_application.tf_cloud.application_id
  app_role_assignment_required = false
}

resource "azurerm_role_assignment" "subscription" {
  scope                = data.azurerm_subscription.primary.id
  role_definition_name = "Contributor"
  principal_id         = azuread_service_principal.tf_cloud.id
}

resource "time_rotating" "main" {
  rotation_days = 10
}

resource "random_password" "tf_cloud" {
  keepers = {
    rotation = time_rotating.main.id
  }

  length  = 32
  special = true
}

resource "azuread_service_principal_password" "tf_cloud" {
  service_principal_id = azuread_service_principal.tf_cloud.id
  value                = random_password.tf_cloud.result
  end_date_relative    = "8760h" #365 days
}

