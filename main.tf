locals {
  endpoint                = var.create_bot ? (var.attach_default_path_to_endpoint ? "${trim(var.endpoint, "/")}/api/messages" : var.endpoint) : null
  microsoft_app_id        = var.create_app ? module.app[0].client_id : var.microsoft_app_id
  microsoft_app_tenant_id = var.create_app ? (var.microsoft_app_type == "SingleTenant" ? data.azuread_client_config.current[0].tenant_id : null) : var.microsoft_app_tenant_id
  default_private_zones = {
    Bot : "directline.botframework.com"
    Token : "token.botframework.com"
  }
  private_endpoints_with_app_sg = { for k, v in var.private_endpoints : k => v if v.create_application_security_group }
}

resource "azurerm_bot_service_azure_bot" "this" {
  count                                 = var.create_bot ? 1 : 0
  name                                  = var.name
  display_name                          = var.display_name
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
  luis_app_ids                          = var.luis_app_ids
  luis_key                              = var.luis_key
  local_authentication_enabled          = var.local_authentication_enabled
  icon_url                              = var.icon_url
  tags                                  = var.tags
}

###########
# Networking
###########
module "private_endpoint" {
  for_each                               = var.create_bot ? var.private_endpoints : {}
  source                                 = "claranet/private-endpoint/azurerm"
  version                                = "7.0.1"
  location                               = var.location
  resource_group_name                    = var.resource_group_name
  custom_private_endpoint_name           = each.key
  custom_private_endpoint_nic_name       = "${each.key}-nic"
  custom_private_service_connection_name = "${each.key}-connection"
  target_resource                        = azurerm_bot_service_azure_bot.this[0].id
  private_dns_zones_vnets_ids            = [each.value.vnet_id]
  subnet_id                              = each.value.subnet_id
  subresource_name                       = lookup(each.value, "subresource", "Bot")
  use_existing_private_dns_zones         = lookup(each.value, "use_existing_private_dns_zone", false)
  private_dns_zones_names                = !lookup(each.value, "use_existing_private_dns_zone", false) ? [local.default_private_zones[lookup(each.value, "subresource", "Bot")]] : []
  private_dns_zones_ids                  = lookup(each.value, "private_dns_zone_ids", [])
  ip_configurations = lookup(each.value, "ip_address", null) != null ? [{
    member_name        = lookup(each.value, "subresource", "Bot")
    private_ip_address = lookup(each.value, "ip_address", null)
  }] : null
  default_tags_enabled = false
  extra_tags           = var.tags
  location_short       = ""
  client_name          = ""
  environment          = ""
  stack                = ""
}

resource "azurerm_application_security_group" "this" {
  for_each            = var.create_bot ? local.private_endpoints_with_app_sg : {}
  name                = "${each.key}-appsecuritygroup"
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

resource "azurerm_private_endpoint_application_security_group_association" "this" {
  for_each                      = var.create_bot ? local.private_endpoints_with_app_sg : {}
  private_endpoint_id           = module.private_endpoint[each.key].private_endpoint_id
  application_security_group_id = azurerm_application_security_group.this[each.key].id
}

###########
# Channels
###########
resource "azurerm_bot_channel_directline" "this" {
  count               = var.create_bot ? 1 : 0
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
  count               = var.create_bot ? 1 : 0
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
