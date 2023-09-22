output "direct_line_channel_id" {
  description = "The Bot Direct Line Channel ID."
  value       = module.bot.direct_line_channel_id
}

output "direct_line_sites" {
  description = "The Direct Line Channel Sites."
  value       = module.bot.direct_line_sites
  sensitive   = true
}

output "web_chat_channel_id" {
  description = "The Bot Web Chat channel ID."
  value       = module.bot.web_chat_channel_id
}
