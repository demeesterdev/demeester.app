provider "acme" {
  alias      = "staging"
  server_url = "https://acme-staging-v02.api.letsencrypt.org/directory"
}

resource "tls_private_key" "acme_key_staging" {
  algorithm   = "ECDSA"
  ecdsa_curve = "P384"
}

resource "acme_registration" "registration_staging" {
  provider        = acme.staging
  account_key_pem = tls_private_key.acme_key_staging.private_key_pem
  email_address   = var.acme_registration_mail
}

resource "azurerm_key_vault_secret" "acme_key_staging" {
  name         = "acme-private-key-staging"
  value        = "tls_private_key.acme_key_staging.private_key_pem"
  key_vault_id = azurerm_key_vault.keystore.id
}

provider "acme" {
  alias      = "production"
  server_url = "https://acme-staging-v02.api.letsencrypt.org/directory"
}

resource "tls_private_key" "acme_key_production" {
  algorithm   = "ECDSA"
  ecdsa_curve = "P384"
}

resource "acme_registration" "registration_production" {
  provider        = acme.production
  account_key_pem = tls_private_key.acme_key_production.private_key_pem
  email_address   = var.acme_registration_mail
}

resource "azurerm_key_vault_secret" "acme_key_production" {
  name         = "acme-private-key-production"
  value        = "tls_private_key.acme_key_production.private_key_pem"
  key_vault_id = azurerm_key_vault.keystore.id
}