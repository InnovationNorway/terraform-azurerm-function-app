output "id" {
  value       = azurerm_function_app.main.id
  description = "The ID of the Function App."
}

output "hostname" {
  value       = azurerm_function_app.main.default_hostname
  description = "The default hostname for the Function App."
}

output "outbound_ips" {
  value       = split(",", azurerm_function_app.main.outbound_ip_addresses)
  description = "A list of outbound IP addresses for the Function App."
}

output "possible_outbound_ips" {
  value       = split(",", azurerm_function_app.main.possible_outbound_ip_addresses)
  description = "A list of possible outbound IP addresses for the Function App. Superset of outbound_ips."
}


output "principal_id" {
  value       = azurerm_function_app.main.identity[0].principal_id
  description = "The principal ID for the system-assigned identity associated with the Function App."
}