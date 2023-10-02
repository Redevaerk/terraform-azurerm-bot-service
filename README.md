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
- [Channels](https://github.com/redevaerk/terraform-azurerm-bot-service/tree/main/examples/single-tenant-with-channels) - This example will create single-tenant bot type with several channels configured.
- [Private Endpoints](https://github.com/redevaerk/terraform-azurerm-bot-service/tree/main/examples/single-tenant-with-private-endpoints) - This example will create single-tenant bot type with private endpoints.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.3 |
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | ~>2.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~>3.75 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azuread"></a> [azuread](#provider\_azuread) | ~>2.0 |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | ~>3.75 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_app"></a> [app](#module\_app) | Redevaerk/application/azuread | 1.1.0 |
| <a name="module_private_endpoint"></a> [private\_endpoint](#module\_private\_endpoint) | claranet/private-endpoint/azurerm | 7.0.1 |

## Resources

| Name | Type |
|------|------|
| [azurerm_application_security_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/application_security_group) | resource |
| [azurerm_bot_channel_directline.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/bot_channel_directline) | resource |
| [azurerm_bot_channel_web_chat.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/bot_channel_web_chat) | resource |
| [azurerm_bot_service_azure_bot.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/bot_service_azure_bot) | resource |
| [azurerm_private_endpoint_application_security_group_association.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint_application_security_group_association) | resource |
| [azuread_client_config.current](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/client_config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_insights_application_id"></a> [app\_insights\_application\_id](#input\_app\_insights\_application\_id) | The resource ID of the Application Insights instance to associate with this Azure Bot Service. | `string` | `null` | no |
| <a name="input_app_insights_key"></a> [app\_insights\_key](#input\_app\_insights\_key) | The Application Insights API Key to associate with this Azure Bot Service. | `string` | `null` | no |
| <a name="input_attach_default_path_to_endpoint"></a> [attach\_default\_path\_to\_endpoint](#input\_attach\_default\_path\_to\_endpoint) | If true, the path /api/messages will be attached to the endpoint | `bool` | `true` | no |
| <a name="input_create_app"></a> [create\_app](#input\_create\_app) | Create a new Microsoft Application for the Azure Bot Service. | `bool` | `false` | no |
| <a name="input_create_bot"></a> [create\_bot](#input\_create\_bot) | Set it to false to not create bot | `bool` | `true` | no |
| <a name="input_direct_line_sites"></a> [direct\_line\_sites](#input\_direct\_line\_sites) | A Direct Line site represents a client application that you want to connect to your bot. | <pre>list(object({<br>    name                            = string<br>    enabled                         = optional(bool)<br>    user_upload_enabled             = optional(bool)<br>    endpoint_parameters_enabled     = optional(bool)<br>    storage_enabled                 = optional(bool)<br>    v1_allowed                      = optional(bool)<br>    v3_allowed                      = optional(bool)<br>    enhanced_authentication_enabled = optional(bool)<br>    trusted_origins                 = optional(list(string))<br>  }))</pre> | <pre>[<br>  {<br>    "enabled": true,<br>    "endpoint_parameters_enabled": false,<br>    "enhanced_authentication_enabled": false,<br>    "name": "default",<br>    "storage_enabled": false,<br>    "trusted_origins": [],<br>    "user_upload_enabled": true,<br>    "v1_allowed": true,<br>    "v3_allowed": true<br>  }<br>]</pre> | no |
| <a name="input_display_name"></a> [display\_name](#input\_display\_name) | The name that the Azure Bot Service will be displayed as. This defaults to the value set for name if not specified. | `string` | `null` | no |
| <a name="input_endpoint"></a> [endpoint](#input\_endpoint) | The Azure Bot Service endpoint. | `string` | `null` | no |
| <a name="input_icon_url"></a> [icon\_url](#input\_icon\_url) | The Icon Url of the Azure Bot Service. | `string` | `null` | no |
| <a name="input_local_authentication_enabled"></a> [local\_authentication\_enabled](#input\_local\_authentication\_enabled) | Is local authentication enabled? Defaults to true. | `bool` | `true` | no |
| <a name="input_location"></a> [location](#input\_location) | The supported Azure location where the Azure Bot Service should exist. Changing this forces a new resource to be created. | `string` | `"global"` | no |
| <a name="input_luis_app_ids"></a> [luis\_app\_ids](#input\_luis\_app\_ids) | A list of LUIS App IDs to associate with this Azure Bot Service. | `list(string)` | `[]` | no |
| <a name="input_luis_key"></a> [luis\_key](#input\_luis\_key) | The LUIS key to associate with this Azure Bot Service. | `string` | `null` | no |
| <a name="input_microsoft_app_id"></a> [microsoft\_app\_id](#input\_microsoft\_app\_id) | The Microsoft Application ID for the Azure Bot Service. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_microsoft_app_tenant_id"></a> [microsoft\_app\_tenant\_id](#input\_microsoft\_app\_tenant\_id) | The Tenant ID of the Microsoft App for this Azure Bot Service. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_microsoft_app_type"></a> [microsoft\_app\_type](#input\_microsoft\_app\_type) | The Microsoft App Type for this Azure Bot Service. Possible values are MultiTenant, SingleTenant and UserAssignedMSI. Changing this forces a new resource to be created. | `string` | `"SingleTenant"` | no |
| <a name="input_name"></a> [name](#input\_name) | The name which should be used for this Azure Bot Service. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_private_endpoints"></a> [private\_endpoints](#input\_private\_endpoints) | Private Endpoints configuration to deploy | <pre>map(object({<br>    vnet_id                           = string<br>    subnet_id                         = string<br>    subresource                       = optional(string, "Bot")<br>    use_existing_private_dns_zone     = optional(bool, false)<br>    private_dns_zone_ids              = optional(list(string), [])<br>    ip_address                        = optional(string, null)<br>    create_application_security_group = optional(bool, false)<br>  }))</pre> | `{}` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the Resource Group where the Azure Bot Service should exist. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_sku"></a> [sku](#input\_sku) | The SKU of the Azure Bot Service. Accepted values are F0 or S1. Changing this forces a new resource to be created. | `string` | `"F0"` | no |
| <a name="input_streaming_endpoint_enabled"></a> [streaming\_endpoint\_enabled](#input\_streaming\_endpoint\_enabled) | Whether the Azure Bot Service Streaming Endpoint should be enabled. | `bool` | `false` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags which should be assigned to this Azure Bot Service. | `map(string)` | `{}` | no |
| <a name="input_web_chat_sites"></a> [web\_chat\_sites](#input\_web\_chat\_sites) | A Web Chat site represents a client application that you want to connect to your bot. | <pre>list(object({<br>    name                        = string<br>    user_upload_enabled         = optional(bool)<br>    endpoint_parameters_enabled = optional(bool)<br>    storage_enabled             = optional(bool)<br>  }))</pre> | <pre>[<br>  {<br>    "endpoint_parameters_enabled": false,<br>    "name": "default",<br>    "storage_enabled": false,<br>    "user_upload_enabled": true<br>  }<br>]</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_direct_line_channel_id"></a> [direct\_line\_channel\_id](#output\_direct\_line\_channel\_id) | The Bot Direct Line Channel ID. |
| <a name="output_direct_line_sites"></a> [direct\_line\_sites](#output\_direct\_line\_sites) | The Direct Line Channel Sites. |
| <a name="output_microsoft_app_id"></a> [microsoft\_app\_id](#output\_microsoft\_app\_id) | The Microsoft Application ID for the Azure Bot Service. |
| <a name="output_microsoft_app_password"></a> [microsoft\_app\_password](#output\_microsoft\_app\_password) | The Microsoft Application Password. |
| <a name="output_microsoft_app_type"></a> [microsoft\_app\_type](#output\_microsoft\_app\_type) | The Microsoft App Type for this Azure Bot Service. |
| <a name="output_microsoft_tenant_id"></a> [microsoft\_tenant\_id](#output\_microsoft\_tenant\_id) | The Tenant ID of the Microsoft App for this Azure Bot Service. |
| <a name="output_private_endpoints"></a> [private\_endpoints](#output\_private\_endpoints) | Private Endpoints. |
| <a name="output_web_chat_channel_id"></a> [web\_chat\_channel\_id](#output\_web\_chat\_channel\_id) | The Web Chat Channel ID. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## License

Apache 2 Licensed. See [LICENSE](https://github.com/redevaerk/terraform-azurerm-bot-service/tree/main/LICENSE) for full details.
