output "client_id" {
  value = azuread_application.this.application_id
}

output "tenant_id" {
  value = data.azuread_client_config.current.tenant_id
}

output "secret_value" {
  value     = azuread_application_password.this.value
  sensitive = true
}
