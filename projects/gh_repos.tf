resource "github_repository" "project" {
  for_each    = { for project in var.projects : project.repository => project }
  name        = each.value.repository

  auto_init = true

  archive_on_destroy = true
}

resource "github_repository_file" "main_tf" {
  for_each   = { for project in var.projects : project.repository => project }
  repository = github_repository.project[each.value.repository].name
  file = "infra/backend.tf"

  overwrite_on_create = "false"

  content = <<-EOF
    terraform {
      backend "remote" {
        organization = "${tfe_organization.primary.name}"
        workspaces {
          name = "${each.value.tf_workspace_name}"
        }
      }
    }
  EOF

}