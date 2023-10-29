output "ip_address" {
  value       = digitalocean_droplet.pernonal_use.ipv4_address
  description = "a public ipv4 address"
}
