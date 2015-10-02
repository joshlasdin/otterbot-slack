require "uri"
require "httparty"

class UrbanDictionary
  BASE_URL = "http://api.urbandictionary.com/v0/define?term="

  def self.search query
    response = HTTParty.get(BASE_URL + URI.encode(query))
    if response.code == 200
      definition = JSON.parse(response.body)["list"].shift
      if definition
        return "/ud #{query} \nDEFINITION: #{definition['definition']}"
      else
        return "otter don't play that '#{query}' game"
      end
    else
      puts "Invalid response from Urban Dictionary: #{response}"
    end

    nil
  end
end
