terraform {
  backend "remote" {
    organization = "demeesterdev"
    workspaces {
      name = "app-infra"
    }
  }
}
