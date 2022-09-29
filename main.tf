variable "subscription_id" {
  type    = string
  default = "8e7e4ee0-b091-4724-bf16-123d5a1a48f3"

}
data "azuread_client_config" "current" {
}
data "azurerm_client_config" "current" {
}
data "azurerm_subscription" "primary" {
}

resource "azurerm_resource_group" "this" {
  name     = "cyberhaven"
  location = var.location
}


resource "azuread_application" "this" {
  display_name            = "cyberhaven_app"
  group_membership_claims = []
}

resource "azuread_application_password" "this" {
  application_object_id = azuread_application.this.object_id
}


resource "azurerm_storage_account" "storage" {
  name                     = "cyberhavenstorageaccount"
  resource_group_name      = azurerm_resource_group.this.name
  location                 = azurerm_resource_group.this.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "container" {
  name                  = "cyberhaven-assets-storage"
  storage_account_name  = azurerm_storage_account.storage.name
  container_access_type = "private"
}

resource "azurerm_role_assignment" "writer" {
  scope              = azurerm_resource_group.this.id
  role_definition_id = split("|", azurerm_role_definition.writer.id)[0]
  principal_id       = azuread_application.this.id
}

resource "azurerm_role_assignment" "reader" {
  scope              = azurerm_resource_group.this.id
  role_definition_id = split("|", azurerm_role_definition.reader.id)[0]
  principal_id       = azuread_application.this.id
}
