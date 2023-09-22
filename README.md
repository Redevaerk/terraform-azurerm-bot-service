# Terraform Azure Bot Service

Streamline the deployment of Azure Bot Services with our Terraform module. 
This all-inclusive solution not only creates your Azure Bot Service instances but also sets up the essential Azure AD application required for seamless authentication and secure interactions. 
Simplify your infrastructure provisioning while ensuring the proper integration of Azure Bot Services with Azure AD, enhancing the efficiency and security of your bot applications.

## Usage

```terraform
module "app" {
  source                     = "Redevaerk/bot-service/azurerm"
  version                    = "x.x.x"
  resource_group_name        = var.resource_group_name
  name                       = var.name
  endpoint                   = var.endpoint
  microsoft_app_id           = var.microsoft_app_id
  microsoft_app_type         = "SingleTenant"
  microsoft_app_tenant_id    = var.tenant_id
  tags = {
    environment = "test"
  }
}
```

## Examples

- [Simple](https://github.com/redevaerk/terraform-azurerm-bot-service/tree/main/examples/simple) - This example will create simple Bot Service.
- [Single Tenant](https://github.com/redevaerk/terraform-azurerm-bot-service/tree/main/examples/single-tenant-with-app) - This example will create single-tenant bot type and also creates the azure ad application.
- [Multi Tenant](https://github.com/redevaerk/terraform-azurerm-bot-service/tree/main/examples/multi-tenant-with-app) - This example will create multi-tenant bot type and also creates the azure ad application.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.3 |
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | >2.0.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >=3.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azuread"></a> [azuread](#provider\_azuread) | >2.0.0 |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >=3.0.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_app"></a> [app](#module\_app) | Redevaerk/application/azuread | 1.1.0 |

## Resources

| Name | Type |
|------|------|
| [azurerm_bot_service_azure_bot.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/bot_service_azure_bot) | resource |
| [azuread_client_config.current](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/client_config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_attach_default_path_to_endpoint"></a> [attach\_default\_path\_to\_endpoint](#input\_attach\_default\_path\_to\_endpoint) | If true, the path /api/messages will be attached to the endpoint | `bool` | `true` | no |
| <a name="input_create_app"></a> [create\_app](#input\_create\_app) | Create a new Microsoft Application for the Azure Bot Service. | `bool` | `false` | no |
| <a name="input_create_bot"></a> [create\_bot](#input\_create\_bot) | Set it to false to not create bot | `bool` | `true` | no |
| <a name="input_endpoint"></a> [endpoint](#input\_endpoint) | The Azure Bot Service endpoint. | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | The supported Azure location where the Azure Bot Service should exist. Changing this forces a new resource to be created. | `string` | `"global"` | no |
| <a name="input_microsoft_app_id"></a> [microsoft\_app\_id](#input\_microsoft\_app\_id) | The Microsoft Application ID for the Azure Bot Service. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_microsoft_app_tenant_id"></a> [microsoft\_app\_tenant\_id](#input\_microsoft\_app\_tenant\_id) | The Tenant ID of the Microsoft App for this Azure Bot Service. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_microsoft_app_type"></a> [microsoft\_app\_type](#input\_microsoft\_app\_type) | The Microsoft App Type for this Azure Bot Service. Possible values are MultiTenant, SingleTenant and UserAssignedMSI. Changing this forces a new resource to be created. | `string` | `"SingleTenant"` | no |
| <a name="input_name"></a> [name](#input\_name) | The name which should be used for this Azure Bot Service. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the Resource Group where the Azure Bot Service should exist. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_sku"></a> [sku](#input\_sku) | The SKU of the Azure Bot Service. Accepted values are F0 or S1. Changing this forces a new resource to be created. | `string` | `"F0"` | no |
| <a name="input_streaming_endpoint_enabled"></a> [streaming\_endpoint\_enabled](#input\_streaming\_endpoint\_enabled) | Whether the Azure Bot Service Streaming Endpoint should be enabled. | `bool` | `false` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags which should be assigned to this Azure Bot Service. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_microsoft_app_id"></a> [microsoft\_app\_id](#output\_microsoft\_app\_id) | The Microsoft Application ID for the Azure Bot Service. |
| <a name="output_microsoft_app_password"></a> [microsoft\_app\_password](#output\_microsoft\_app\_password) | The Microsoft Application Password. |
| <a name="output_microsoft_app_type"></a> [microsoft\_app\_type](#output\_microsoft\_app\_type) | The Microsoft App Type for this Azure Bot Service. |
| <a name="output_microsoft_tenant_id"></a> [microsoft\_tenant\_id](#output\_microsoft\_tenant\_id) | The Tenant ID of the Microsoft App for this Azure Bot Service. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## License

Apache 2 Licensed. See [LICENSE](https://github.com/redevaerk/terraform-azurerm-bot-service/tree/main/LICENSE) for full details.
