resource "azurerm_storage_account" "sa-attachments" {
  name                            = replace(local.name_template_short, "<service>", "sa")
  resource_group_name             = azurerm_resource_group.rg.name
  location                        = var.default_location
  account_tier                    = "Standard"
  account_replication_type        = "GRS"
  account_kind                    = "StorageV2"
  default_to_oauth_authentication = true
  min_tls_version                 = "TLS1_2"
  allow_nested_items_to_be_public = false
  # shared_access_key_enabled       = false # not possible with tf
}

# Enable and configure Defender for Storage at the storage account level
resource "azapi_resource_action" "enable-defender-for-sa" {
  type        = "Microsoft.Security/defenderForStorageSettings@2022-12-01-preview"
  resource_id = "${azurerm_storage_account.sa.id}/providers/Microsoft.Security/defenderForStorageSettings/current"
  method      = "PUT"

  body = {
    properties = {
      isEnabled = true
      malwareScanning = {
        onUpload = {
          isEnabled              = true
          capGBPerMonth          = 1
          blobScanResultsOptions = "BlobIndexTags"
        }
      }
      sensitiveDataDiscovery = {
        isEnabled = true
      }
      overrideSubscriptionLevelSettings = true
      automatedResponse                 = "BlobSoftDelete"
    }
  }
}
