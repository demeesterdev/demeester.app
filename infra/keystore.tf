data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "keystore" {
  name     = "${var.resource_prefix}-keys"
  location = "West Europe"
}

resource "azurerm_key_vault" "keystore" {
  name                = "${var.resource_prefix}-keys"
  location            = azurerm_resource_group.keystore.location
  resource_group_name = azurerm_resource_group.keystore.name
  tenant_id           = data.azurerm_client_config.current.tenant_id

  sku_name = "standard"
}

resource "azurerm_dns_txt_record" "keystore" {
  name                = "keystore"
  zone_name           = azurerm_dns_zone.app_dns_public.name
  resource_group_name = azurerm_resource_group.dns.name
  ttl                 = 300

  record {
    value = azurerm_key_vault.keystore.id
  }
}

resource "azurerm_key_vault_access_policy" "terraform_spn" {
  key_vault_id = azurerm_key_vault.keystore.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azurerm_client_config.current.object_id

  key_permissions = [
    "get",
  ]

  secret_permissions = [
      "set",
      "get",
      "delete",
      "purge",
      "recover"
    ]
}