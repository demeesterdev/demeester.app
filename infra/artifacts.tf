resource "azurerm_resource_group" "artifacts" {
  name     = "${var.resource_prefix}-artifacts"
  location = "West Europe"
}

resource "azurerm_dns_cname_record" "artifacts" {
  name                = var.artifacts_dubdomain
  zone_name           = azurerm_dns_zone.app_dns_public.name
  resource_group_name = azurerm_resource_group.dns.name
  ttl                 = 300
  record              = "${var.resource_prefix}artifacts.z5.web.core.windows.net"
}

resource "azurerm_storage_account" "artifacts" {
  name                     = "${var.resource_prefix}artifacts"
  resource_group_name      = azurerm_resource_group.artifacts.name
  location                 = azurerm_resource_group.artifacts.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
  min_tls_version          = "TLS1_2"

  custom_domain {
    name = azurerm_dns_cname_record.artifacts.fqdn
  }

  lifecycle {
    prevent_destroy = true
  }

  static_website {
    error_404_document = "404.html"
  }
}

data "azurerm_storage_container" "artifacts_web" {
  name                 = "$web"
  storage_account_name = azurerm_storage_account.artifacts.name
}

resource "azurerm_storage_blob" "artifacts_web_404" {
  name                   = "404.json"
  storage_account_name   = azurerm_storage_account.artifacts.name
  storage_container_name = data.azurerm_storage_container.artifacts_web.name
  type                   = "Block"
  source_content         = "<HTML><body>Not Found</body></HTML>"
}


