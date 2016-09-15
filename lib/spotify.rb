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

  def self.track_search artist, title
    options = {
      q: "#{artist} #{title}",
      type: :track,
    }
    response = HTTParty.get(BASE_URL + "search", query: options)
    if response.code == 200
      json = JSON.parse(response.body)
      if json && json["tracks"]["items"].length > 0
        track = json["tracks"]["items"][0]
        return track["uri"]
      end
    else
      puts "Unable to find a spotify tracks: #{response}"
    end

    nil
  end
end
