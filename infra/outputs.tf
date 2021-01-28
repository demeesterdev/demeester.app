output "dns_zone_name" {
  value = azurerm_dns_zone.demdev-dns-public.name
}

output "dns_zone_resource_group_name" {
  value = azurerm_resource_group.demdev-dns.name
}

output "dns_zone_servers" {
  value = azurerm_dns_zone.demdev-dns-public.name_servers
}