output "client_id" {
  value = azuread_application.this.id
}

output "tenant_id" {
  value = azuread_application.this
}

output "secret_value" {
  value     = azuread_application_password.this.value
  sensitive = true
}
