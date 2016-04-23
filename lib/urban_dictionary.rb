require "uri"
require "httparty"

class UrbanDictionary
  BASE_URL = "http://api.urbandictionary.com/v0/define?term="

  def self.search query
    response = HTTParty.get(BASE_URL + URI.encode(query))
    if response.code == 200
      definition = JSON.parse(response.body)["list"].shift
      definition['definition']
    else
      puts "Invalid response from Urban Dictionary: #{response}"
      nil
    end
  end
end
