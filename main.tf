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
  owners                  = [data.azuread_client_config.current.object_id]
}

resource "azuread_service_principal" "this" {
  application_id               = azuread_application.this.application_id
  app_role_assignment_required = false
  owners                       = [data.azuread_client_config.current.object_id]

  feature_tags {
    enterprise = true
    gallery    = false
  }
}

resource "azuread_service_principal_password" "this" {
  service_principal_id = azuread_service_principal.this.object_id
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
  principal_id       = azuread_service_principal.this.id
}

resource "azurerm_role_assignment" "reader" {
  count              = var.allow_read ? 1 : 0
  scope              = azurerm_resource_group.this.id
  role_definition_id = split("|", azurerm_role_definition.reader.id)[0]
  principal_id       = azuread_service_principal.this.id
}
