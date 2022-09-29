resource "azurerm_role_definition" "reader" {
  name        = "cyberhaven-bucket-reader"
  scope       = data.azurerm_subscription.primary.id
  description = "Cyberhaven role for read access"

  permissions {
    actions      = ["Microsoft.Storage/storageAccounts/blobServices/containers/read"]
    data_actions = ["Microsoft.Storage/storageAccounts/blobServices/containers/blobs/read"]
    not_actions  = []
  }

  assignable_scopes = [
    azurerm_resource_group.this.id
  ]
}

resource "azurerm_role_definition" "writer" {
  name        = "cyberhaven-bucket-writer"
  scope       = data.azurerm_subscription.primary.id
  description = "Cyberhaven role for read access"

  permissions {
    actions = [
      "Microsoft.Storage/storageAccounts/blobServices/containers/write",
    ]
    not_actions = []
    data_actions = [
      "Microsoft.Storage/storageAccounts/blobServices/containers/blobs/write",
      "Microsoft.Storage/storageAccounts/listkeys/action",
      "Microsoft.Storage/storageAccounts/blobServices/containers/blobs/move/action",
      "Microsoft.Storage/storageAccounts/blobServices/containers/blobs/add/action"
    ]
  }

  assignable_scopes = [
    azurerm_resource_group.this.id
  ]
}
