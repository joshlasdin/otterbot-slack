require 'httparty'

class LastFm
  BASE_URL = "http://ws.audioscrobbler.com/2.0/"

  def self.top_album username, index
    lastfm_api_key = ENV['LAST_FM_API_KEY'].to_s

    raise ArgumentError.new("LAST_FM_API_KEY must be set in your ENV to search google") if lastfm_api_key.empty?

    options = {
      method: "user.gettopalbums",
      user: username,
      period: "overall",
      limit: 1,
      page: index,
      format: :json,
      api_key: lastfm_api_key
    }
    response = HTTParty.get(BASE_URL, query: options)
    if response.code == 200
      json = JSON.parse(response.body)
      if json && json["topalbums"] && json["topalbums"]["album"].length > 0
        return json["topalbums"]["album"][0]
      end
    else
      puts "Unable to find a users last fm albums: #{response}"
    end

    nil
  end
end
