terraform {
  cloud {
    hostname     = "app.terraform.io"
    organization = "ilyasoi"

    workspaces {
      name = "fem-eci-tfe"
    }
  }
}