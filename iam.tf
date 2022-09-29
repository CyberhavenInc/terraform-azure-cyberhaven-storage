resource "azurerm_role_definition" "reader" {
  name        = "cyberhaven-bucket-reader"
  scope       = data.azurerm_subscription.primary.id
  description = "Cyberhaven role for read access"

  assignable_scopes = [
    data.azurerm_subscription.primary.id,
    azurerm_resource_group.this.id,
    azurerm_storage_account.storage.id
  ]

  permissions {
    actions = [
      "Microsoft.Storage/storageAccounts/blobServices/containers/read",
      "Microsoft.Storage/storageAccounts/listkeys/action",
    ]
    data_actions = ["Microsoft.Storage/storageAccounts/blobServices/containers/blobs/read"]
    not_actions  = []
  }

}

resource "azurerm_role_definition" "writer" {
  name        = "cyberhaven-bucket-writer"
  scope       = data.azurerm_subscription.primary.id
  description = "Cyberhaven role for write access"
  assignable_scopes = [
    data.azurerm_subscription.primary.id,
    azurerm_resource_group.this.id,
    azurerm_storage_account.storage.id
  ]
  permissions {
    actions = [
      "Microsoft.Storage/storageAccounts/blobServices/containers/write",
      "Microsoft.Storage/storageAccounts/listkeys/action",
    ]
    not_actions = []
    data_actions = [
      "Microsoft.Storage/storageAccounts/blobServices/containers/blobs/write",
      "Microsoft.Storage/storageAccounts/blobServices/containers/blobs/move/action",
      "Microsoft.Storage/storageAccounts/blobServices/containers/blobs/add/action"
    ]
  }


}
