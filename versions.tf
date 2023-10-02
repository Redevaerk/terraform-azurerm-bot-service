terraform {
  required_version = ">= 1.5.3"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.75"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~>2.0"
    }
  }
}
