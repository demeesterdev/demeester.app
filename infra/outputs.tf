output "application_domain_name" {
  value = var.application_domain
}

output "application_dns_zone_servers" {
  value = azurerm_dns_zone.app_dns_public.name_servers
}