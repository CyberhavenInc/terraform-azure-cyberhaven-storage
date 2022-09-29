provider "azurerm" {
  features {}
}

terraform {
  #   version on azure bash
  required_version = "~> 1.2.2"
}


provider "azuread" {
  tenant_id = "8e7e4ee0-b091-4724-bf16-123d5a1a48f3"
}
