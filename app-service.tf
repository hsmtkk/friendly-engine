resource "random_string" "suffix" {
  length  = 8
  special = false
}

resource "azurerm_service_plan" "east" {
  location            = var.east
  name                = "east"
  os_type             = "Windows"
  resource_group_name = azurerm_resource_group.default.name
  sku_name            = "D1"
}

resource "azurerm_windows_web_app" "east" {
  location            = azurerm_service_plan.east.location
  name                = "east${random_string.suffix.id}"
  resource_group_name = azurerm_resource_group.default.name
  service_plan_id     = azurerm_service_plan.east.id
  site_config {
    always_on = false
    application_stack {
      current_stack  = "dotnet"
      dotnet_version = "v6.0"
    }
  }
}

resource "azurerm_app_service_custom_hostname_binding" "east" {
  app_service_name    = azurerm_windows_web_app.east.name
  hostname            = "east.curlychainsawa.gq"
  resource_group_name = azurerm_resource_group.default.name
}

#resource "azurerm_app_service_source_control" "east" {
#  app_id   = azurerm_windows_web_app.east.id
#  repo_url = ""
#  branch   = ""
#}