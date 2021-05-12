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

resource "azurerm_key_vault_secret" "dns_zone_id" {
  name         = "demeesterapp-dns-resource"
  key_vault_id = azurerm_key_vault.keystore.id
  value        = jsonencode({
    "name" = azurerm_dns_zone.app_dns_public.name
    "resource_group_name" = azurerm_dns_zone.app_dns_public.resource_group_name
  })
}
