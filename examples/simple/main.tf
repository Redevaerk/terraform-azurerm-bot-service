provider "azurerm" {
  features {}
}

module "bot" {
  source                     = "../../"
  resource_group_name        = var.resource_group_name
  name                       = var.name
  endpoint                   = var.endpoint
  microsoft_app_id           = var.microsoft_app_id
  microsoft_app_type         = "SingleTenant"
  microsoft_app_tenant_id    = var.tenant_id
  streaming_endpoint_enabled = true
  tags = {
    environment = "test"
  }
}
