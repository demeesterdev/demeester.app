resource "github_repository" "project" {
  for_each    = { for project in var.projects : project.repository => project }
  name        = each.value.repository

  auto_init = true

  archive_on_destroy = true
}