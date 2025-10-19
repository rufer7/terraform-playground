# terraform-playground

[![CI/CD](https://github.com/rufer7/terraform-playground/actions/workflows/ci-cd.yml/badge.svg)](https://github.com/rufer7/terraform-playground/actions/workflows/ci-cd.yml)
[![License](https://img.shields.io/badge/license-Apache%20License%202.0-blue.svg)](https://github.com/rufer7/terraform-playground/blob/main/LICENSE)

Repository for playing around with Terraform and for testing purposes

## Getting started

### Prerequisites

- Azure tenant with a subscription and permissions to create resources and app registrations
- [Azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli?WT.mc_id=MVP_344197)
- [Terraform 1.13.3](https://developer.hashicorp.com/terraform/install?product_intent=terraform)

### Deploy resources to host terraform state

1. Adjust values in `iac-core\vars\dev.core.tfvars`
1. Create resources to host terraform state by executing the following commands

   ```PowerShell
   az login -t [AZURE_TENANT_ID]
   cd [PATH_TO_REPOSITORY]\iac-core
   terraform init
   terraform apply --var-file=.\vars\dev.core.tfvars
   ```

### Deploy application resources

> [!IMPORTANT]
> To generate deployment credentials and to configure the secrets for the GitHub actions workflow, see [here](https://learn.microsoft.com/en-us/azure/app-service/deploy-github-actions?tabs=openid%2Caspnetcore&WT.mc_id=MVP_344197#manually-set-up-a-github-actions-workflow).
> There is currently one GitHub environment set up for this repository: `dev-iac`.
> For this environment, a separate federated credential is set up in the Entra app which got created while generating deployment credentials.
> Furthermore the service principal of the Entra app is a member of the Entra group `tf-playground-rg-iac` and the following Microsoft Graph application permissions got added
>
> - `Application.ReadWrite.All`
> - `Domain.Read.All`
> - `Group.ReadWrite.All`
>
> Finally, the service principal was assigned the `Owner` role for the resource group.

> [!NOTE]
> The application resources are created via GitHub actions workflow. The following steps are only required, if you want to create the resources manually.

1. Adjust values in `iac\vars\dev.app.tfvars`
1. Adjust values in `iac\backend\dev.backend.tfvars`
1. Create application resources using the following commands

   ```PowerShell
   az login -t [AZURE_TENANT_ID]
   cd [PATH_TO_REPOSITORY]\iac
   terraform init --backend-config=backend\dev.backend.tfvars
   terraform apply --var-file=.\vars\dev.app.tfvars --state=dev.app.tfstate
   ```

## Useful links

- [Set up a GitHub Actions workflow manually](https://learn.microsoft.com/en-us/azure/app-service/deploy-github-actions?tabs=openid%2Caspnetcore&WT.mc_id=MVP_344197#set-up-a-github-actions-workflow-manually)
- [Authenticating using a Service Principal and OpenID Connect](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/guides/service_principal_oidc)
