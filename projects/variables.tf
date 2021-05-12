variable "projects" {
  type = list(object({
    repository        = string
    tf_workspace_name = string
    working_directory = string
  }))
  default = [
    {

      repository        = "demeester.app",
      tf_workspace_name = "app-infra",
      working_directory = "/infra"
    },
    {
      tf_workspace_name = "cloud-proxy",
      repository        = "proxy.demeester.app"
      working_directory = "/infra"
    },
    {
      tf_workspace_name = "homecluster-cloud-infra",
      repository        = "home.demeester.app"
      working_directory = "/infra"
    },
    {
      tf_workspace_name = "static",
      repository        = "static.demeester.app"
      working_directory = "/infra"
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
    name  = "demeesterdev"
    email = "app.terraform.io@demeester.dev"
    # https://app.terraform.io/api/v2/organizations/demeesterdev/oauth-clients
    oauth_client = "oc-A1aC38r24YaHkpU3"
  }
}

variable "github_owner" {
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
  description = "primary subscription where terraform infra will be deployed"
  default     = "37e54a95-aa6a-44b4-bb70-98492bccf76c"
}
