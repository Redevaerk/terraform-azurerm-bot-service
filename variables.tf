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

###########
# Microsoft Application
###########
variable "create_app" {
  description = "Create a new Microsoft Application for the Azure Bot Service."
  type        = bool
  default     = false
}