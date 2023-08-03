data "dns_a_record_set" "east" {
  host = azurerm_windows_web_app.east.default_hostname
}

resource "azurerm_dns_zone" "curlychainsawa" {
  name                = "curlychainsawa.gq"
  resource_group_name = azurerm_resource_group.default.name
}

resource "azurerm_dns_a_record" "east" {
  name                = "east"
  resource_group_name = azurerm_resource_group.default.name
  ttl                 = 0
  zone_name           = azurerm_dns_zone.curlychainsawa.name
  records             = [data.dns_a_record_set.east.addrs[0]]
}

resource "azurerm_dns_txt_record" "east" {
  name                = "asuid.east"
  resource_group_name = azurerm_resource_group.default.name
  ttl                 = 0
  zone_name           = azurerm_dns_zone.curlychainsawa.name
  record {
    value = azurerm_windows_web_app.east.custom_domain_verification_id
  }
}