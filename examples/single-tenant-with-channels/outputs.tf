output "direct_line_channel_id" {
  description = "The Bot Direct Line Channel ID."
  value       = module.bot.direct_line_channel_id
}

output "direct_line_sites" {
  description = "The Direct Line Channel Sites."
  value       = module.bot.direct_line_sites
  sensitive   = true
}
