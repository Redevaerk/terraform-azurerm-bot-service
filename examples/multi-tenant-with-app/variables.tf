variable "resource_group_name" {
  description = "The name of the Resource Group where the Azure Bot Service should exist. Changing this forces a new resource to be created."
  type        = string
}

variable "name" {
  description = "The name which should be used for this Azure Bot Service. Changing this forces a new resource to be created."
  type        = string
}

variable "endpoint" {
  description = "The Azure Bot Service endpoint."
  type        = string
}

variable "microsoft_app_id" {
  description = "The Microsoft Application ID for the Azure Bot Service. Changing this forces a new resource to be created."
  type        = string
}

variable "tenant_id" {
  description = "The tenant id of AzureAD"
  type        = string
}
