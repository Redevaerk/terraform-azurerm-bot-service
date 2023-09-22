locals {
  endpoint                = var.create_bot ? (var.attach_default_path_to_endpoint ? "${trim(var.endpoint, "/")}/api/messages" : var.endpoint) : null
  microsoft_app_id        = var.create_app ? module.app[0].client_id : var.microsoft_app_id
  microsoft_app_tenant_id = var.create_app ? (var.microsoft_app_type == "SingleTenant" ? data.azuread_client_config.current[0].tenant_id : null) : var.microsoft_app_tenant_id
}

resource "azurerm_bot_service_azure_bot" "this" {
  count                                 = var.create_bot ? 1 : 0
  name                                  = var.name
  resource_group_name                   = var.resource_group_name
  location                              = var.location
  microsoft_app_type                    = var.microsoft_app_type
  microsoft_app_id                      = local.microsoft_app_id
  microsoft_app_tenant_id               = local.microsoft_app_tenant_id
  sku                                   = var.sku
  endpoint                              = local.endpoint
  streaming_endpoint_enabled            = var.streaming_endpoint_enabled
  developer_app_insights_application_id = var.app_insights_application_id
  developer_app_insights_key            = var.app_insights_key
  tags                                  = var.tags
}



###########
# Channels
###########
resource "azurerm_bot_channel_directline" "this" {
  bot_name            = var.name
  location            = var.location
  resource_group_name = var.resource_group_name

  dynamic "site" {
    for_each = try(var.direct_line_sites[*], [])
    content {
      name                            = site.value.name
      enabled                         = lookup(site.value, "enabled", true)
      user_upload_enabled             = lookup(site.value, "user_upload_enabled", true)
      endpoint_parameters_enabled     = lookup(site.value, "endpoint_parameters_enabled", false)
      storage_enabled                 = lookup(site.value, "storage_enabled", true)
      v1_allowed                      = lookup(site.value, "v1_allowed", true)
      v3_allowed                      = lookup(site.value, "v3_allowed", true)
      enhanced_authentication_enabled = lookup(site.value, "enhanced_authentication_enabled", false)
      trusted_origins                 = lookup(site.value, "trusted_origins", [])
    }
  }

  depends_on = [
    azurerm_bot_service_azure_bot.this
  ]
}

resource "azurerm_bot_channel_web_chat" "this" {
  bot_name            = var.name
  location            = var.location
  resource_group_name = var.resource_group_name

  dynamic "site" {
    for_each = try(var.web_chat_sites[*], [])
    content {
      name                        = site.value.name
      user_upload_enabled         = lookup(site.value, "user_upload_enabled", true)
      endpoint_parameters_enabled = lookup(site.value, "endpoint_parameters_enabled", false)
      storage_enabled             = lookup(site.value, "storage_enabled", true)

    }
  }

  depends_on = [
    azurerm_bot_service_azure_bot.this
  ]
}


###########
# Microsoft Application
###########
data "azuread_client_config" "current" {
  count = var.create_app && var.microsoft_app_type == "SingleTenant" ? 1 : 0
}

module "app" {
  count                    = var.create_app ? 1 : 0
  source                   = "Redevaerk/application/azuread"
  version                  = "1.1.0"
  display_name             = "${var.name}-app"
  generate_password        = true
  create_service_principal = var.microsoft_app_type == "MultiTenant" ? false : true
  sign_in_audience         = var.microsoft_app_type == "MultiTenant" ? "AzureADandPersonalMicrosoftAccount" : "AzureADMyOrg"
  api = var.microsoft_app_type == "MultiTenant" ? {
    requested_access_token_version = 2
  } : {}
}
