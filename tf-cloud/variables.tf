variable "workspaces" {
  type = list(object({
    name              = string
    repository        = string
    working_directory = string
  }))
  default = [
    {
      name              = "app-infra",
      repository        = "demeester.app"
      working_directory = "/infra"
    },
    {
      name              = "chef-training",
      repository        = "chef-training"
      working_directory = ""
    }
  ]
}

variable "tfe_organization" {
  type = object({
    name         = string
    email        = string
    oauth_client = string

  })
  default = {
    name         = "demeesterdev"
    email        = "app.terraform.io@demeester.dev"
    # https://app.terraform.io/api/v2/organizations/demeesterdev/oauth-clients
    oauth_client = "oc-A1aC38r24YaHkpU3"
  }
}

variable "github_workspace" {
  default = "demeesterdev"
}

variable "azuread_app_name" {
  default = "app.terraform.io (demeesterdev)"
}

variable "tenant_id" {
  # tenant id for demeester.dev
  # https://login.windows.net/demeester.dev/.well-known/openid-configuration
  default = "33fc39ad-c870-4015-85f0-81c3ae60e53a"
}
variable "subscription_id" {
  description = "prima subscription where terraform infra will be deployed"
  default     = "37e54a95-aa6a-44b4-bb70-98492bccf76c"
}
