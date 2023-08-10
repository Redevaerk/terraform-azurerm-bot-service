output "microsoft_app_type" {
  description = "The Microsoft App Type for this Azure Bot Service."
  value       = var.microsoft_app_type
}

output "microsoft_app_id" {
  description = "The Microsoft Application ID for the Azure Bot Service."
  value       = azurerm_bot_service_azure_bot.this.microsoft_app_id
}

output "microsoft_tenant_id" {
  description = "The Tenant ID of the Microsoft App for this Azure Bot Service."
  value       = azurerm_bot_service_azure_bot.this.microsoft_app_tenant_id
}

output "microsoft_app_password" {
  description = "The Microsoft Application Password."
  value       = var.create_app ? module.app[0].app_client_secret : null
  sensitive   = true
}
