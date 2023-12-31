provider "azurerm" {
  features {}
}

module "bot" {
  source              = "../../"
  resource_group_name = var.resource_group_name
  name                = var.name
  endpoint            = var.endpoint
  create_app          = true
  microsoft_app_type  = "SingleTenant"
  direct_line_sites = [{
    name    = "default"
    enabled = true
    },
    {
      name                            = "with-auth"
      enabled                         = true
      enhanced_authentication_enabled = true
      trusted_origins                 = ["https://www.example.com"]
    }
  ]
}
