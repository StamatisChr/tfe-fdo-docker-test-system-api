output "tfe_url" {
  description = "tfe-fqdn"
  value       = "https://${random_pet.hostname_suffix.id}.${var.hosted_zone_name}"
}

output "admin_password" {
  description = "Admin password for TFE"
  value       = var.admin_password
  sensitive   = true
}

output "admin_username" {
  description = "Admin username for TFE"
  value       = var.admin_username
}

output "systemapicall" {
  description = "System API call for TFE"
  value       = <<EOT
    curl -s \
    --header "Authorization: Bearer $TOKEN" \
    --request GET https://${random_pet.hostname_suffix.id}.${var.hosted_zone_name}:8443/api/v1/ping | jq
    EOT
}