#!/usr/bin/env ruby
require "rubygems"
require "sinatra"
require "json"
require "./lib/slack"
require "./lib/google_image_search"

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

  case command
  when "/pic"
    slack = Slack.new
    image = GoogleImageSearch.search text
    message = "#{command} #{text} (#{username})"
    if image
      message << " " << image
    else
      message << " 404. otter has no such things."
    end
    slack.post_message message
  else
    puts "Unknown command: #{command}. Text: #{text}"
  end

  nil
end
