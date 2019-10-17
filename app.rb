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
require "./lib/cute_plz"
require "./lib/last_fm"
require "./lib/spotify"

# ensures foreman doesn't buffer console output
$stdout.sync = true

Spotify.authenticate!

LAST_FM_USERS = ["jayteemo", "fredguy", "acashk", "joshualehman", "jolbyandfriends", "dan_hazard", "stevenkasprzyk"]

get "/" do
  send_file 'public/index.html'
end

get "/roller" do
  number = rand(1..2000)

  url = ""
  LAST_FM_USERS.shuffle.each do |username|
    album = LastFm.top_album username, number
    if album
      url = Spotify.album_search album['artist']['name'], album['name']

      break if url
    end
  end

  url
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
  response_url = params[:response_url]
  reply_options = {}

  message = nil

  slack = Slack.new
  case command
  when "/pic"
    image = GoogleImageSearch.search text
    if image
      # Slack says urls with equals signs are 'invalid_payload', so hack around that
      message = image.gsub("=", "%3D")
    else
      message = "404. otter has no such things."
    end
  when "/ud"
    definition = UrbanDictionary.search text
    if definition
      message = definition
    else
      message = "otter doesn't play that #{text} game"
    end
  when "/shouldi"
    decision = Decider.decide text
    if decision
      message = "otter has decided: #{decision}"
    end
  when "/8ball"
    decision = Magic8Ball.shake
    message = "Magic 8 Ball says: #{decision}"
  when "/gifball"
    decision = MagicGifBall.shake
    message = "Magic Gif Ball says: #{decision}"
  when  "/lastfmroll"
    number = rand(1..5000)
    albums = LAST_FM_USERS.map do |username|
      album = LastFm.top_album username, number
      if album
        url = Spotify.album_search album['artist']['name'], album['name']
        link = url ? " <#{url}|Spotify Link>" : ""
        "#{username}: #{album['artist']['name']} - #{album['name']}#{link}"
      end
    end
    message = ":game_die:#{emojify_number(number)}:heavy_exclamation_mark:\n" + albums.select { |a| a && !a.empty? }.join("\n")
    reply_options[:unfurl_media] = false
  when  "/throwback"
    number = rand(1..500)
    track = LastFm.top_track "IndieAndSuch", number
    if track
      url = Spotify.track_search track['artist']['name'], track['name']
      message = "#{number}: #{track['artist']['name']} - #{track['name']} #{url}".strip
    end
  when "/rfi"
    # this is "roll for initiative" aka a random number generator for a game
    message = rand(1..20).to_s
  when "/coinflip"
    message = ["HEADS!", "TAILS!"].sample
  when "/cuteplz"
    message = CutePlz.cuteness text
  else
    message = "Unknown command: #{command}. #{params.inspect}"
  end

  if message && message.length > 0
    response_message = formatted_response username, command, text, message
    slack.reply response_url, response_message, reply_options
  end

  nil
end

def formatted_response username, command, text, message
  text = " #{text}" if text && text.length > 0
  "#{username} #{command}#{text}\n#{message}"
end

DIGIT_MAPPING = {
  0 => "zero",
  1 => "one",
  2 => "two",
  3 => "three",
  4 => "four",
  5 => "five",
  6 => "six",
  7 => "seven",
  8 => "eight",
  9 => "nine"
}

def emojify_number value
  value.to_i.to_s.each_char.map { |digit|  ":#{DIGIT_MAPPING[digit.to_i]}:" }.join("")
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
