resource "azurerm_resource_group" "artifacts" {
  name     = "${var.resource_prefix}-artifacts"
  location = "West Europe"
}

resource "azurerm_storage_account" "artifacts" {
  name                     = "${var.resource_prefix}artifacts"
  resource_group_name      = azurerm_resource_group.artifacts.name
  location                 = azurerm_resource_group.artifacts.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
  min_tls_version          = "TLS1_2"

  custom_domain {
      name = "${var.artifacts_dubdomain}.${azurerm_dns_zone.app_dns_public.name}"
  }

  lifecycle {
    prevent_destroy = true
  }
}

resource "azurerm_dns_cname_record" "artifacts" {
  name                = var.artifacts_dubdomain
  zone_name           = azurerm_dns_zone.app_dns_public.name
  resource_group_name = azurerm_resource_group.dns.name
  ttl                 = 300
  record              = azurerm_storage_account.artifacts.primary_blob_host
}