#!/usr/bin/env ruby
require "rubygems"
require "sinatra"
require "json"
require "cgi"
require "./lib/slack"
require "./lib/google_image_search"
require "./lib/urban_dictionary"
require "./lib/decider"
require "./lib/magic_8_ball"
require "./lib/magic_gif_ball"

# ensures foreman doesn't buffer console output
$stdout.sync = true

get "/" do
  send_file 'public/index.html'
end

post "/" do
  params = parse_slack_data(request.body.read)

  unless ENV['TOKENS'].to_s.split(",").include?(params[:token])
    puts "Invalid request token: #{params.inspect}"
    return nil
  end

  command = params[:command].to_s.strip.downcase
  text = params[:text].to_s.strip
  username = params[:user_name]

  slack = Slack.new
  case command
  when "/pic"
    image = GoogleImageSearch.search text
    message = "#{command} #{text} (#{username})"
    if image
      message << " " << image
    else
      message << " 404. otter has no such things."
    end
    slack.post_message message
  when "/ud"
    definition = UrbanDictionary.search text
    if definition
      slack.post_message definition
    end
  when "/shouldi"
    decision = Decider.decide text
    if decision
      slack.post_message "#{command} #{text}\n #{username} otter says: #{decision}"
    end
  when "/8ball"
    decision = Magic8Ball.shake
    slack.post_message "#{command} #{text}\n#{username} Magic 8 Ball says: #{decision}"
  when "/gifball"
    decision = MagicGifBall.shake
    slack.post_message "#{command} #{text}\n#{username} Magic Gif Ball says: #{decision}"
  when "/rfi"
    # this is "roll for initiative" aka a random number generator for a game
    result = rand(1..20)
    slack.post_message "#{username} #{command}\n#{result}"
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
