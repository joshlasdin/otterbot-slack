#!/usr/bin/env ruby
require "rubygems"
require "sinatra"
require "json"

# ensures foreman doesn't buffer console output
$stdout.sync = true

get "/" do
  send_file 'public/index.html'
end

"""
Data Slack POST's:
token=gIkuvaNzQIHg97ATvDxqgjtO
team_id=T0001
team_domain=example
channel_id=C2147483705
channel_name=test
user_id=U2147483697
user_name=Steve
command=/weather
text=94070
"""
post "/" do
  body = JSON.parse(request.body.read)

  command = body["command"].to_s.strip.downcase
  text = body["text"].to_s.strip
  username = body["user_name"]

  puts "#{command} #{text} from #{username}"
end
