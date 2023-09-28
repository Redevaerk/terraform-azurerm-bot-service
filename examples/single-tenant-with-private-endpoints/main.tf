provider "azurerm" {
  features {}
}

locals {
  private_endpoints = {
    TokenEndpoint = {
      vnet_id     = module.vnet.virtual_network_id
      subnet_id   = module.subnet.subnet_id
      subresource = "Token"
      ip_address  = cidrhost(module.subnet.subnet_cidr_list[0], 34)
    },
    BotEndpoint = {
      vnet_id                       = module.vnet.virtual_network_id
      subnet_id                     = module.subnet.subnet_id
      subresource                   = "Bot"
      use_existing_private_dns_zone = true
      private_dns_zone_ids          = [azurerm_private_dns_zone.zone1.id, azurerm_private_dns_zone.zone2.id]
    }
  }
}

module "vnet" {
  source              = "claranet/vnet/azurerm"
  version             = "5.2.0"
  location            = var.location
  resource_group_name = var.resource_group_name
  vnet_cidr           = ["10.10.0.0/16"]
  custom_vnet_name    = "${var.name}-vnet"

  use_caf_naming       = false
  default_tags_enabled = false
  location_short       = ""
  environment          = ""
  client_name          = ""
  stack                = ""
}

module "subnet" {
  source               = "claranet/subnet/azurerm"
  version              = "6.2.0"
  resource_group_name  = var.resource_group_name
  virtual_network_name = module.vnet.virtual_network_name
  custom_subnet_name   = "${var.name}-private-subnet"
  subnet_cidr_list     = ["10.10.0.0/24"]
  use_caf_naming       = false
  location_short       = "" # Not Used
  client_name          = "" # Not Used
  environment          = "" # Not Used
  stack                = "" # Not Used
}

resource "azurerm_private_dns_zone" "zone1" {
  name                = "example.com"
  resource_group_name = var.resource_group_name
}

resource "azurerm_private_dns_zone" "zone2" {
  name                = "example2.com"
  resource_group_name = var.resource_group_name
}

module "bot" {
  source              = "../../"
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  endpoint            = var.endpoint
  create_app          = true
  private_endpoints   = local.private_endpoints
  tags = {
    env = "test"
  }
}
