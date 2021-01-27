output "dns_zone_servers" {
  value = azurerm_dns_zone.demdev-dns-public.name_servers
}