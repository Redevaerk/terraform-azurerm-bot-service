###########
# Azure
###########
variable "resource_group_name" {
  description = "The name of the Resource Group where the Azure Bot Service should exist. Changing this forces a new resource to be created."
  type        = string
}

variable "location" {
  description = "The supported Azure location where the Azure Bot Service should exist. Changing this forces a new resource to be created."
  type        = string
  default     = "global"
}

###########
# Bot
###########
variable "create_bot" {
  description = "Set it to false to not create bot"
  type        = bool
  default     = true
}

variable "name" {
  description = "The name which should be used for this Azure Bot Service. Changing this forces a new resource to be created."
  type        = string
}

variable "sku" {
  description = "The SKU of the Azure Bot Service. Accepted values are F0 or S1. Changing this forces a new resource to be created."
  type        = string
  default     = "F0"
  validation {
    condition     = contains(["F0", "S1"], var.sku)
    error_message = "Valid value is one of the following: F0 and S1."
  }
}

variable "endpoint" {
  description = "The Azure Bot Service endpoint."
  type        = string
  default     = null
}

variable "attach_default_path_to_endpoint" {
  description = "If true, the path /api/messages will be attached to the endpoint"
  type        = bool
  default     = true
}

variable "microsoft_app_id" {
  description = "The Microsoft Application ID for the Azure Bot Service. Changing this forces a new resource to be created."
  type        = string
  default     = null
}

variable "microsoft_app_type" {
  description = "The Microsoft App Type for this Azure Bot Service. Possible values are MultiTenant, SingleTenant and UserAssignedMSI. Changing this forces a new resource to be created."
  type        = string
  default     = "SingleTenant"
  validation {
    condition     = contains(["MultiTenant", "SingleTenant", "UserAssignedMSI"], var.microsoft_app_type)
    error_message = "Valid value is one of the following: MultiTenant, SingleTenant or UserAssignedMSI."
  }
}

variable "microsoft_app_tenant_id" {
  description = "The Tenant ID of the Microsoft App for this Azure Bot Service. Changing this forces a new resource to be created."
  type        = string
  default     = null
}

variable "streaming_endpoint_enabled" {
  description = "Whether the Azure Bot Service Streaming Endpoint should be enabled."
  type        = bool
  default     = false
}

variable "tags" {
  description = "A mapping of tags which should be assigned to this Azure Bot Service."
  type        = map(string)
  default     = {}
}

variable "app_insights_application_id" {
  description = "The resource ID of the Application Insights instance to associate with this Azure Bot Service."
  type        = string
  default     = null
}

variable "app_insights_key" {
  description = "The Application Insights API Key to associate with this Azure Bot Service."
  type        = string
  default     = null
}

variable "display_name" {
  description = "The name that the Azure Bot Service will be displayed as. This defaults to the value set for name if not specified."
  type        = string
  default     = null
}

variable "local_authentication_enabled" {
  description = "Is local authentication enabled? Defaults to true."
  type        = bool
  default     = true
}

variable "icon_url" {
  description = "The Icon Url of the Azure Bot Service."
  type        = string
  default     = null
}
###########
# Microsoft Application
###########
variable "create_app" {
  description = "Create a new Microsoft Application for the Azure Bot Service."
  type        = bool
  default     = false
}

###########
# Private Endpoints
###########
variable "private_endpoints" {
  description = "Private Endpoints configuration to deploy"
  type = map(object({
    vnet_id                           = string
    subnet_id                         = string
    subresource                       = optional(string, "Bot")
    use_existing_private_dns_zone     = optional(bool, false)
    private_dns_zone_ids              = optional(list(string), [])
    ip_address                        = optional(string, null)
    create_application_security_group = optional(bool, false)
  }))
  default = {}
}

###########
# Luis
###########
variable "luis_app_ids" {
  description = "A list of LUIS App IDs to associate with this Azure Bot Service."
  type        = list(string)
  default     = []
}

variable "luis_key" {
  description = "The LUIS key to associate with this Azure Bot Service."
  type        = string
  default     = null
  sensitive   = true
}

###########
# Channels
###########
variable "direct_line_sites" {
  description = "A Direct Line site represents a client application that you want to connect to your bot."
  type = list(object({
    name                            = string
    enabled                         = optional(bool)
    user_upload_enabled             = optional(bool)
    endpoint_parameters_enabled     = optional(bool)
    storage_enabled                 = optional(bool)
    v1_allowed                      = optional(bool)
    v3_allowed                      = optional(bool)
    enhanced_authentication_enabled = optional(bool)
    trusted_origins                 = optional(list(string))
  }))
  default = [{
    name                            = "default"
    enabled                         = true
    user_upload_enabled             = true
    endpoint_parameters_enabled     = false
    storage_enabled                 = false
    v1_allowed                      = true
    v3_allowed                      = true
    enhanced_authentication_enabled = false
    trusted_origins                 = []
  }]
}

variable "web_chat_sites" {
  description = "A Web Chat site represents a client application that you want to connect to your bot."
  type = list(object({
    name                        = string
    user_upload_enabled         = optional(bool)
    endpoint_parameters_enabled = optional(bool)
    storage_enabled             = optional(bool)
  }))
  default = [{
    name                        = "default"
    user_upload_enabled         = true
    endpoint_parameters_enabled = false
    storage_enabled             = false
  }]
}
