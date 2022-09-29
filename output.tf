locals {
  configuration = <<EOF
{
  "client_secret": "${azuread_service_principal_password.this.value}",
  "container_name": "${azurerm_storage_container.container.name}",
  "storage_account_name": "${azurerm_storage_account.storage.name}",
  "tenant_id": "${data.azuread_client_config.current.tenant_id}",
  "client_id": "${azuread_application.this.application_id}",
  "resources_group": "${azurerm_resource_group.this.name}",
  "subscription": "${data.azurerm_subscription.primary.subscription_id}"
}
    EOF
}
resource "local_file" "configuration" {
  content  =  local.configuration 
  filename = "${path.module}/configuration"
}