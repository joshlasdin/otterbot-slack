require "uri"
require "httparty"

class UrbanDictionary
  BASE_URL = "http://api.urbandictionary.com/v0/define?term="

  def self.search query
    response = HTTParty.get(BASE_URL + URI.encode(query))
    if response.code == 200
      json = JSON.parse(response.body)
      if json && json["list"] && json["list"].length > 0
        json["list"][0]["definition"]
      else
        nil
      end
    else
      puts "Invalid response from Urban Dictionary: #{response}"
      nil
    end
  end
end
