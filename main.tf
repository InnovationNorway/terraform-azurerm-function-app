locals {
  app_service_plan_id = coalesce(var.app_service_plan_id, azurerm_app_service_plan.main[0].id)
  
  storage_account_name = replace(
    lower(substr(var.name, 0, min(18, length(var.name)))),
    "/[^a-z0-9]/",
    "",
  )
  
  location = coalesce(var.location, data.azurerm_resource_group.main.location)
}

data "azurerm_resource_group" "main" {
  name = var.resource_group_name
}

resource "random_id" "main" {
  byte_length = 2
}

resource "azurerm_storage_account" "main" {
  name                     = format("%s%s", local.storage_account_name, random_id.main.hex)
  resource_group_name      = data.azurerm_resource_group.main.name
  location                 = local.location
  account_tier             = "Standard"
  account_replication_type = "RAGRS"
  tags                     = var.tags
}

resource "azurerm_app_service_plan" "main" {
  count               = var.app_service_plan_id == "" ? 1 : 0
  name                = format("%s-plan", var.name)
  location            = local.location
  resource_group_name = data.azurerm_resource_group.main.name

  sku {
    tier = split("_", var.sku)[0]
    size = split("_", var.sku)[1]
  }

  tags = var.tags
}

resource "azurerm_function_app" "main" {
  name                      = var.name
  location                  = local.location
  resource_group_name       = data.azurerm_resource_group.main.name
  app_service_plan_id       = local.app_service_plan_id
  storage_connection_string = azurerm_storage_account.main.primary_connection_string
  https_only                = var.https_only
  version                   = var.runtime_version
  client_affinity_enabled   = var.client_affinity_enabled

  site_config {
    always_on = var.always_on
  }

  identity {
    type = "SystemAssigned"
  }

  app_settings = var.app_settings

  tags = var.tags
}
