require "httparty"

class Slack
  USERNAME = "otterbot"
  ICON_EMOJI = ":otter:"

  def initialize
    @webhook_url = ENV['WEBHOOK_URL'].to_s
    @channel = ENV['CHANNEL'].to_s

    raise ArgumentError.new("WEBHOOK_URL must be set in your ENV to post to slack") if @webhook_url.empty?
    raise ArgumentError.new("CHANNEL must be set in your ENV to post to slack") if @channel.empty?
  end

  def post_message message, channel=nil
    return false if message.to_s.strip.empty?

    body = {
      text: message,
      channel: channel || @channel,
      username: USERNAME,
      icon_emoji: ICON_EMOJI
    }
    response = HTTParty.post(@webhook_url, body: body.to_json)
    if response.code == 200
      true
    else
      puts "Error posting to slack: #{response}"
      false
    end
  end

  def reply response_url, message
    return false if response_url.to_s.strip.empty?
    return false if message.to_s.strip.empty?

    body = {
      text: message,
      response_type: "in_channel"
    }
    response = HTTParty.post(response_url, body: body.to_json)
    if response.code == 200
      true
    else
      puts "Error posting to slack: (#{response.code}) #{response.response.body}"
      false
    end
  end
end
