output "microsoft_app_type" {
  description = "The Microsoft App Type for this Azure Bot Service."
  value       = var.microsoft_app_type
}

output "microsoft_app_id" {
  description = "The Microsoft Application ID for the Azure Bot Service."
  value       = local.microsoft_app_id
}

output "microsoft_tenant_id" {
  description = "The Tenant ID of the Microsoft App for this Azure Bot Service."
  value       = local.microsoft_app_tenant_id
}

output "microsoft_app_password" {
  description = "The Microsoft Application Password."
  value       = var.create_app ? module.app[0].app_client_secret : null
  sensitive   = true
}

###########
# Channels
###########
output "direct_line_channel_id" {
  description = "The Bot Direct Line Channel ID."
  value       = var.create_bot ? azurerm_bot_channel_directline.this[0].id : null
}

output "direct_line_sites" {
  description = "The Direct Line Channel Sites."
  value       = var.create_bot ? azurerm_bot_channel_directline.this[0].site : null
  sensitive   = true
}

output "web_chat_channel_id" {
  description = "The Web Chat Channel ID."
  value       = var.create_bot ? azurerm_bot_channel_web_chat.this[0].id : null
}

###########
# Private Endpoints
###########
output "private_endpoints" {
  description = "Private Endpoints."
  value       = var.create_bot ? module.private_endpoint[*] : null
}
#
#output "private_endpoint_ip_address" {
#  description = "The Private Endpoint IP Address."
#  value       = var.create_bot && var.vnet_integration_enabled ? module.private_endpoint[0].private_endpoint_ip_address : null
#}
#
#output "application_security_group_id" {
#  description = "The Application Security Group ID."
#  value       = var.create_bot && var.vnet_integration_enabled && var.create_application_security_group ? azurerm_application_security_group.this[0].id : null
#}
#
