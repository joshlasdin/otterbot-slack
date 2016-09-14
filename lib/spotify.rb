require 'httparty'

class Spotify
  BASE_URL = "https://api.spotify.com/v1/"

  def self.album_search artist, title
    options = {
      q: "#{artist} #{title}",
      type: :album,
    }
    response = HTTParty.get(BASE_URL + "search", query: options)
    if response.code == 200
      json = JSON.parse(response.body)
      if json && json["albums"]["items"].length > 0
        album = json["albums"]["items"][0]
        return album["uri"]
      end
    else
      puts "Unable to find a spotify albums: #{response}"
    end

    nil
  end
end
