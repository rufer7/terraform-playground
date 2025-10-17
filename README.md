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

