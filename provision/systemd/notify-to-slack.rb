#!/usr/bin/ruby
# frozen_string_literal: true
require 'json'
require 'uri'
require 'open3'
require 'net/http'

unless ENV.key?('SLACK_WEBHOOK_URL')
  abort('Set SLACK_WEBHOOK_URL into /etc/systemd/system/notify-to-slack.env')
end
uri = URI(ENV['SLACK_WEBHOOK_URL'])
unit = ARGV.shift
text, status = Open3.capture2e(*%W"systemctl status --full #{unit}")
payload = { text: text }
payload[:username] = ENV['SLACK_USERNAME'] if ENV.key?('SLACK_USERNAME')
payload[:icon_emoji] = ENV['SLACK_ICON_EMOJI'] if ENV.key?('SLACK_ICON_EMOJI')
headers = {
  'content-type' => 'application/json',
}
http = Net::HTTP.new(uri.host, uri.port)
http.use_ssl = true
http.set_debug_output $stderr if $DEBUG
response = http.post(uri.path, payload.to_json, headers)
puts "#{response} #{response.body}"
