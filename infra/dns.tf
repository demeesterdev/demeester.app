resource "azurerm_resource_group" "dns" {
  name     = "${var.resource_prefix}-dns"
  location = "West Europe"
}

resource "azurerm_dns_zone" "app_dns_public" {
  name                = var.application_domain
  resource_group_name = azurerm_resource_group.dns.name

  lifecycle {
    prevent_destroy = true
  }
}

resource "azurerm_dns_a_record" "local" {
  name                = "local"
  zone_name           = azurerm_dns_zone.app_dns_public.name
  resource_group_name = azurerm_resource_group.dns.name
  ttl                 = 300
  records             = ["127.0.0.1"]
}