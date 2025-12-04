locals {
  project = {
    "fem-eci-project" = {
      description = "Example description of project"
    }
  }

  workspace = {
    "kilmer-mba-tfe" = {
      description    = "Example automation workspace for Terraform Cloud resources."
      execution_mode = "remote"
      project_id     = module.project["fem-eci-project"].id
      vcs_repo_identifier = "${var.github_organization_name}/kilmer-mba-terraform-tfe"
    }

    "kilmer-mba-github" = {
      description    = "Example automation workspace for Terraform Cloud resources."
      execution_mode = "remote"
      project_id     = module.project["fem-eci-project"].id
      vcs_repo_identifier = "${var.github_organization_name}/kilmer-mba-terraform-github"
    }

    "kilmer-mba-rg" = {
      description    = "Example automation workspace for Terraform Cloud resources."
      execution_mode = "remote"
      project_id     = module.project["fem-eci-project"].id
      vcs_repo_identifier = "${var.github_organization_name}/kilmer-mba-terraform-azure-rg"
      variables = [
        {
          key          = "location"
          value        = "spaincentral"
          category     = "terraform"
          hcl          = false
          sensitive    = false
        },
        {
          key          = "name"
          value        = "mba"
          category     = "terraform"
          hcl          = false
          sensitive    = false
        }
      ]
    }

    "kilmer-mba-azure-network" = {
      description = "Automation for Azure network resources"
      execution_mode = "remote"
      project_id = module.project["fem-eci-project"].id
      vcs_repo_identifier = "${var.github_organization_name}/kilmer-mba-terraform-azure-network"
      variables = [
        {
          key         = "organization_name"
          value       = var.organization_name
          category     = "terraform"
          hcl         = true
          sensitive   = false
        },
        {
          key         = "rg_workspace_name"
          value       = "kilmer-mba-rg"
          category     = "terraform"
          hcl         = false
          sensitive   = false
        },
        {
          key          = "location"
          value        = "spaincentral"
          category     = "terraform"
          hcl          = false
          sensitive    = false
        },
        {
          key          = "rg_name"
          value        = "mba"
          category     = "terraform"
          hcl          = false
          sensitive    = false
        },
        {
          key          = "vnet_name"
          value        = "vnet-myResourceGroup"
          category     = "terraform"
          hcl          = false
          sensitive    = false
        },
        {
          key          = "vnet_cidr"
          value        = "155.55.0.0/16"
          category     = "terraform"
          hcl          = false
          sensitive    = false
        },
        {
          key          = "subscription_id"
          value        = "10453ec5-bcb7-4ed7-9f6c-4e741f3611a8"
          category     = "terraform"
          sensitive    = true
        },
        {
          key          = "subnets"
          value = replace(trimspace(<<EOT
            {
              "subnet-aks" = {
                new_bits = 8
                nsg = {
                  name  = "nsg-aks"
                  rules = []
                }
              }
            }
            EOT
          ), "\r\n", "\n")
          category     = "terraform"
          hcl          = true
          sensitive    = false
        }
      ]

    }
  }
}