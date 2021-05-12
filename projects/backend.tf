terraform {
  backend "remote" {
    organization = "demeesterdev"

    workspaces {
      name = "projects"
    }
  }
}