locals {
  endpoint = var.attach_default_path_to_endpoint ? "${trim(var.endpoint, "/")}/api/messages" : var.endpoint
}

resource "azurerm_bot_service_azure_bot" "this" {
  name                       = var.name
  resource_group_name        = var.resource_group_name
  location                   = var.location
  microsoft_app_type         = var.microsoft_app_type
  microsoft_app_id           = var.create_app ? module.app[0].client_id : var.microsoft_app_id
  microsoft_app_tenant_id    = var.create_app ? (var.microsoft_app_type == "SingleTenant" ? data.azuread_client_config.current[0].tenant_id : null) : var.microsoft_app_tenant_id
  sku                        = var.sku
  endpoint                   = local.endpoint
  streaming_endpoint_enabled = var.streaming_endpoint_enabled
  tags                       = var.tags
}

#developer_app_insights_application_id
#developer_app_insights_key

#microsoft_app_msi_id - (Optional) The ID of the Microsoft App Managed Identity for this Azure Bot Service. Changing this forces a new resource to be created.
#luis_app_ids - (Optional) A list of LUIS App IDs to associate with this Azure Bot Service.
##luis_key - (Optional) The LUIS key to associate with this Azure Bot Service.

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
