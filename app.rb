#!/usr/bin/env ruby
require "rubygems"
require "sinatra"
require "json"
require "cgi"
require "./lib/slack"
require "./lib/google_image_search"

# ensures foreman doesn't buffer console output
$stdout.sync = true

get "/" do
  send_file 'public/index.html'
end

post "/" do
  params = parse_slack_data(request.body.read)

  if params[:token] != ENV['TOKEN']
    puts "Invalid request token: #{params.inspect}"
    return nil
  end

  command = params[:command].strip.downcase
  text = params[:text].strip
  username = params[:user_name]

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
    puts "Unknown command: #{command}. #{params.inspect}"
  end

  nil
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
def parse_slack_data body
  body.to_s.split("&").each_with_object({}) do |line, h|
    tokens = line.split("=")
    next unless tokens.length == 2
    h[tokens[0].to_sym] = CGI.unescape(tokens[1])
  end
end
