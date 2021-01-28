resource "tfe_organization" "primary" {
  name  = var.tfe_organization.name
  email = var.tfe_organization.email
}

data "tfe_oauth_client" "github" {
  oauth_client_id = var.tfe_organization.oauth_client
}

resource "tfe_workspace" "infra" {
  for_each           = { for workspace in var.workspaces : workspace.name => workspace }
  auto_apply         = true
  allow_destroy_plan = true
  name               = each.value.name
  organization       = tfe_organization.primary.id
  working_directory  = each.value.working_directory

  vcs_repo {
    identifier         = "${var.github_workspace}/${each.value.repository}"
    ingress_submodules = false
    oauth_token_id     = data.tfe_oauth_client.github.oauth_token_id
  }
}

locals {
  # setproduct works with sets and lists, but our variables are both maps
  # so we'll need to convert them first.
  az_variable = [
    ["ARM_CLIENT_SECRET", random_password.tf_cloud.result],
    ["ARM_CLIENT_ID", azuread_service_principal.tf_cloud.application_id],
    ["ARM_SUBSCRIPTION_ID", data.azurerm_subscription.primary.subscription_id],
    ["ARM_TENANT_ID", var.tenant_id],
    ["CONFIRM_DESTROY", "1"]
  ]

  etf_variables = flatten([
    for workspace in tfe_workspace.infra : [
      for pair in local.az_variable : {
        name         = "${workspace.name}_${pair[0]}"
        workspace_id = workspace.id
        key          = pair[0]
        value        = pair[1]
      }
    ]
  ])
}

resource "tfe_variable" "azureprovider" {
  for_each     = { for var in local.etf_variables : var.name => var }
  key          = each.value.key
  value        = each.value.value
  category     = "env"
  workspace_id = each.value.workspace_id
  description  = "Authentication env variable for provider hashicorp/azuread"
  sensitive    = true
}

